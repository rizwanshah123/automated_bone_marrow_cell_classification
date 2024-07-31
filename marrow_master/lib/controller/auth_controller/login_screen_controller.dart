import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/home_screen/home_main_screen.dart';
import '../../view/otp_screen.dart';

class LoginScreenController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Rx<User?> user = Rx<User?>(null);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  RxBool showPassword = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Get.offAll(() => const HomeMainScreen());
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    isLoading.value = true;
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _saveLoginStatus(true);
        clearFields();
        Get.offAll(() => const HomeMainScreen());
      } on FirebaseAuthException catch (e) {
        passwordController.clear();
        Get.snackbar(
          'Error',
          e.message ?? 'Login failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar(
        'Error',
        'Please enter both email and password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false;
        update(); // Prints after 1 second.
      });
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
      await _saveLoginStatus(true);
      Get.to(() => const HomeMainScreen());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong please try again later',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
    update();
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _saveLoginStatus(false);
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> _saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }
}
