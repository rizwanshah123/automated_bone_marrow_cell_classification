import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../view/auth_screen/login_screen.dart';

// RegisterScreenController
class RegisterScreenController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode fullNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  RxBool showPassword = true.obs;
  RxBool showConfirmPassword = true.obs;
  RxBool isLoading = false.obs;

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  bool isValidFullName(String name) {
    if (name.isEmpty) return false;
    final firstChar = name[0];
    const specialChars =
        "!@#\$%^&*(),.?\":{}|<>"; // Add any other special characters you want to exclude
    if (specialChars.contains(firstChar) ||
        RegExp(r'[0-9]').hasMatch(firstChar)) {
      return false;
    }
    return true;
  }

  Future<void> register() async {
    isLoading.value = true;

    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar('Error', 'Invalid email format',
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoading.value = false;
      update();
      return;
    }

    if (!isValidFullName(fullNameController.text.trim())) {
      Get.snackbar('Error',
          'Full name must not start with a number or special character',
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoading.value = false;
      update();
      return;
    }

    if (fullNameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      Get.snackbar('Error', 'All fields are required',
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoading.value = false;
      update();
      return;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      Get.snackbar('Error', 'Passwords do not match',
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoading.value = false;
      update();
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      // Save user details in Firestore
      await saveUserDetails(userCredential.user!.uid);

      fullNameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      // Show dialog to the user
      Get.defaultDialog(
        title: 'Verification Email Sent',
        content: const Text(
          'A verification link has been sent to your registered email. Please verify it before logging in.',
          textAlign: TextAlign.center,
        ),
        confirm: ElevatedButton(
          onPressed: () {
            Get.offAll(() => LoginScreen()); // Close the dialog
          },
          child: const Text('OK'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar('Error',
            'User already exists with this email. Please try with another email.',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        Get.snackbar('Error', e.message ?? 'Registration failed.',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } finally {
      isLoading.value = false; // Set loading state back to false
    }
  }

  Future<void> saveUserDetails(String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'fullName': fullNameController.text.trim(),
      'contactNo': '',
      'profession': '',
      'gender': '',
      'profileImageUrl': '',
      'email': emailController.text.trim(),
    });
  }
}
