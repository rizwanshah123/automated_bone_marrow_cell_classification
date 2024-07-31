import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller/forget_password_cotroller.dart';
import 'auth_screen_component/custom_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'login_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final ForgetPasswordController _forgetPasswordController =
      Get.put(ForgetPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new,
                      size: 35, color: Color(0xff184C9A)),
                  onPressed: () => Get.back(),
                ),
                SizedBox(width: 10.w),
                const Text('Forget Password',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff184C9A)))
              ]),
              SizedBox(height: 1.h),
              SizedBox(
                height: 20.h,
                child: Lottie.asset(
                  'assets/images/data.json',
                  height: 27.h,
                  width: 37.w,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: 100.w,
                child: Text(
                  "Have you forget your Password don't worry just entered your email you have registered with.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.9),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                width: 95.w,
                child: TextFormField(
                  controller: _forgetPasswordController.emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter Email Address',
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
              SizedBox(
                height: 5.h,
              ),
              customButton(
                'Next',
                () {
                  _forgetPasswordController.resetPassword();
                },
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
