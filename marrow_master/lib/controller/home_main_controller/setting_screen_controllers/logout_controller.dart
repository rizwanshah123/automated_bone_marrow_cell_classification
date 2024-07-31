import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../view/auth_screen/login_screen.dart';

class LogoutController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logout() async {
    try {
      await _auth.signOut();
      await _saveLoginStatus(false);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      Get.offAll(() => LoginScreen());
    }
  }

  Future<void> _saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }
}
