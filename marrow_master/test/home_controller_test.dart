import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marrow_master/firebase_options.dart';
import 'package:marrow_master/view/home_screen/result_screen/result_screen.dart';
import 'package:mockito/mockito.dart';
import 'package:marrow_master/controller/home_main_controller/home_screens_controller/home_controller.dart';
import 'package:marrow_master/data/repository/home_repository.dart';

// Import your controller and other dependencies


// Mock classes for dependencies
class MockHomeRepository extends Mock implements HomeRepository {}



class MockGetNavigation extends Mock implements GetInterface {}


void main() {
    setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });
  group('HomeController Tests', () {
    late HomeController controller;
    late MockHomeRepository mockRepository;
    late MockGetNavigation mockGet;

    setUp(() {
      mockRepository = MockHomeRepository();
      mockGet = MockGetNavigation();
      controller = HomeController();
      Get.put(mockRepository); // Inject mock repository
      Get.put(mockGet); // Inject mock Get navigation
    });

    tearDown(() {
      Get.reset(); // Reset Get bindings after each test
    });

    test('pickImage() success case', () async {
      // Mock image picker
      final mockPickedFile = PickedFile('test_image.jpg');
      when(controller.pickImage(anyNamed('source') as ImageSource))
          .thenAnswer((_) async => mockPickedFile);

      // Mock uploadImage method
      when(mockRepository.uploadImage(any)).thenAnswer((_) async => {
            'predictions': {'test_name': 'test_description'}
          });

      // Mock selectedImage value
      controller.selectedImage.value = File(mockPickedFile.path);

      await controller.pickImage(ImageSource.gallery);

      // Verify navigation to ResultScreen
      verify(mockGet.to(const ResultScreen(), arguments: {
        'name': 'test_name',
        'description': 'test_description',
        'image': controller.selectedImage.value!.path,
        'check': true,
      })).called(1);

      // Verify uploadImageToHistory was called
      verify(controller.uploadImageToHistory('test_name', 'test_description'))
          .called(1);
    });

    test('pickImage() no image selected case', () async {
      // Mock image picker returning null
      when(controller.pickImage( anyNamed('source') as ImageSource))
          .thenAnswer((_) async {});

      await controller.pickImage(ImageSource.gallery);

      // Verify snackbar shown
      verify(mockGet.snackbar('Error', 'No image selected',
          backgroundColor: Colors.red, colorText: Colors.white)).called(1);

      // Verify isLoading state
      expect(controller.isLoading.value, false);
    });

    // Add more test cases as needed for error handling, edge cases, etc.
  });
}
