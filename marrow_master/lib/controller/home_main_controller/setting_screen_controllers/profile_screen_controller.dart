import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:marrow_master/view/home_screen/home_main_screen.dart';

class ProfileController extends GetxController {
  var fullName = ''.obs;
  var contactNo = ''.obs;
  var profession = ''.obs;
  var gender = ''.obs;
  var profileImageUrl = ''.obs;
  RxBool isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  late TextEditingController fullNameController;
  late TextEditingController contactNoController;
  late TextEditingController professionController;

  @override
  void onInit() {
    super.onInit();
    fullNameController = TextEditingController();
    contactNoController = TextEditingController();
    professionController = TextEditingController();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          fullName.value = userDoc['fullName'] ?? '';
          contactNo.value = userDoc['contactNo'] ?? '';
          profession.value = userDoc['profession'] ?? '';
          gender.value = userDoc['gender'] ?? '';
          profileImageUrl.value = userDoc['profileImageUrl'] ?? '';

          fullNameController.text = fullName.value;
          contactNoController.text = contactNo.value;
          professionController.text = profession.value;
        } else {
          print('User document does not exist');
          clearFields();
        }
      } else {
        print('No user is currently signed in');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      Get.snackbar('Error', 'Failed to fetch user profile: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void clearFields() {
    fullName.value = '';
    contactNo.value = '';
    profession.value = '';
    gender.value = '';
    profileImageUrl.value = '';

    fullNameController.text = '';
    contactNoController.text = '';
    professionController.text = '';
  }

  bool isValidFullName(String name) {
    if (name.isEmpty) return false;

    const specialChars =
        "!@#\$%^&*(),.?\":{}|<>"; // Add any other special characters you want to exclude
    if (specialChars.contains(name) || RegExp(r'[0-9]').hasMatch(name)) {
      return false;
    }
    return true;
  }

  bool isValidContactNo(String contact) {
    return RegExp(r'^\d+$').hasMatch(contact);
  }

  bool isValidProfession(String profession) {
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(profession);
  }

  bool isValidGender(String gender) {
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(gender);
  }

  void updateUserProfile() async {
    if (!isValidFullName(fullNameController.text.trim())) {
      Get.snackbar('Error',
          'Full name must not start with a number or special character',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (!isValidContactNo(contactNoController.text.trim())) {
      Get.snackbar('Error', 'Contact number must be numeric only',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (!isValidProfession(professionController.text.trim())) {
      Get.snackbar('Error', 'Profession must contain only alphabets',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (!isValidGender(gender.value.trim())) {
      Get.snackbar('Error', 'Gender must contain only alphabets',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'fullName': fullNameController.text.trim(),
          'contactNo': contactNoController.text.trim(),
          'profession': professionController.text.trim(),
          'gender': gender.value.trim(),
          'profileImageUrl': profileImageUrl.value,
        }, SetOptions(merge: true));
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        fetchUserProfile();
        Get.to(() => const HomeMainScreen());
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile');
    } finally {
      isLoading.value = false;
    }
  }

  void pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        await uploadImageToFirebase(imageFile);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image');
    }
  }

  Future<void> uploadImageToFirebase(File imageFile) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        Reference storageRef =
            _storage.ref().child('profileImages/${user.uid}');
        UploadTask uploadTask = storageRef.putFile(imageFile);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        profileImageUrl.value = downloadUrl;
        updateUserProfile();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image');
    }
  }
}
