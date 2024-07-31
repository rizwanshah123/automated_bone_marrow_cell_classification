import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:marrow_master/view/auth_screen/auth_screen_component/custom_button.dart';

import '../../../data/repository/home_repository.dart';
import '../../../view/home_screen/result_screen/result_screen.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _imagePicker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);
  var isLoading = false.obs;
  final HomeRepository _homeRepository = HomeRepository();
  var userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          userName.value = userDoc['name'] ?? 'User';
        }
      }
    } catch (e) {
      print('Error fetching user name: $e');
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        isLoading.value = true; // Set loading state before processing
        await _uploadAndProcessImage(selectedImage.value!);
      } else {
        isLoading.value = false; // Reset loading state if no image is picked
      }
    } catch (e) {
      print('Error picking image: $e');
      Get.snackbar('Error', 'Failed to pick image',
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoading.value = false; // Reset loading state on error
    }
  }

  Future<void> _uploadAndProcessImage(File imageFile) async {
    try {
      // Upload image to backend and process response
      final response = await _homeRepository.uploadImage(imageFile);
      if (response != null && response is Map<String, dynamic>) {
        if (response.containsKey('predictions')) {
          Map<String, dynamic> predictions = response['predictions'];
          print("the value of Prediction is $predictions");
          String name = '';
          String description = '';
          predictions.forEach((key, value) {
            name = key;
            description = value;
            return;
          });

          if (name.toLowerCase() == 'other') {
            isLoading.value = false;
            // Show alert box instead of navigating and uploading metadata
            Get.defaultDialog(
                title: 'Wrong Picture Uploaded',
                content: const Text(
                    'Uploaded the Wrong Image Please Try with Appropriate Cell Image'),
                confirm: customButton("Ok", () => Get.back()));
          } else {
            // Upload image metadata to history
            await uploadImageToHistory(name, description);

            // Reset loading state before navigating
            isLoading.value = false;

            Get.to(() => const ResultScreen(), arguments: {
              'name': name,
              'description': description,
              'image': selectedImage.value!.path,
              'check': true,
            });
          }
        } else {
          throw Exception('Predictions key not found in response');
        }
      } else {
        throw Exception('Failed to upload image or invalid response format');
      }
    } catch (e) {
      print('Error uploading image: $e');
      Get.snackbar('Error', 'Something Went Wrong Please Try Again',
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoading.value = false; // Reset loading state on error
    }
  }

  Future<void> uploadImageToHistory(String name, String description) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not logged in');

      final String imageURL =
          await uploadImageToFirebaseStorage(selectedImage.value!);

      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formattedDate = formatter.format(now);

      await _firestore.collection('history').add({
        'userId': user.uid,
        'name': name,
        'description': description,
        'image': imageURL,
        'date': formattedDate,
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image to history: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('images/$fileName');

      await ref.putFile(imageFile);
      String downloadURL = await ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return '';
    }
  }
}
