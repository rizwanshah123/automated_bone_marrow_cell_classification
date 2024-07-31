import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../view/auth_screen/login_screen.dart';

class ForgetPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();

  @override
  void onClose() {
    emailController.dispose();
    emailFocus.dispose();
    super.onClose();
  }

  Future<void> resetPassword() async {
    try {
      if (!GetUtils.isEmail(emailController.text.trim())) {
        Get.snackbar('Error', 'Invalid email format',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }
      await _auth.sendPasswordResetEmail(email: emailController.text);

      emailController.clear();

      Get.snackbar('Success', 'Password reset email sent!',
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.to(() => LoginScreen());
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
