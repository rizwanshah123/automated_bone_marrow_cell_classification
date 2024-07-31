
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller/register_Screen_controller.dart';
import 'auth_screen_component/custom_button.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final RegisterScreenController _registerController =
      Get.put(RegisterScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Image.asset('assets/images/signinbg.png')),
            SizedBox(height: 1.h),
            const Text(
              "Create New Account",
              style: TextStyle(
                  color: Color(0xff184C9A),
                  fontWeight: FontWeight.w800,
                  fontSize: 24),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              width: 95.w,
              height: 8.h,
              child: TextFormField(
                controller: _registerController.fullNameController,
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xff000000),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            SizedBox(
              width: 95.w,
              height: 8.h,
              child: TextFormField(
                controller: _registerController.emailController,
                decoration: InputDecoration(
                  hintText: 'Email ',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xff000000),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            StatefulBuilder(
              builder: (context, setState) {
                return SizedBox(
                  width: 95.w,
                  height: 8.h,
                  child: TextFormField(
                    obscureText: _registerController.showPassword.value,
                    controller: _registerController.passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _registerController.togglePasswordVisibility();
                          });
                        },
                        icon: Icon(_registerController.showPassword.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xff000000),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 3.h),
            StatefulBuilder(
              builder: (context, setState) {
                return SizedBox(
                  width: 95.w,
                  height: 8.h,
                  child: TextFormField(
                    obscureText: _registerController.showConfirmPassword.value,
                    controller: _registerController.confirmPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _registerController
                                .toggleConfirmPasswordVisibility();
                          });
                        },
                        icon: Icon(_registerController.showConfirmPassword.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xff000000),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 5.h),
            Obx(() => _registerController.isLoading.value
                ? const CircularProgressIndicator()
                : customButton(
                    'SignUp',
                    () {
                      _registerController.register();
                    },
                  )),
            SizedBox(
              height: 2.h,
            ),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                  text: "Already Have an Account?\t\t\t",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff736868)),
                  children: [
                    TextSpan(
                      text: 'Sign In',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff184C9A),
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle the onTap event for "Sign Up"
                          Get.to(() => LoginScreen());
                        },
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
