import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../home_screen/home_main_screen.dart';
import 'auth_screen_component/custom_button.dart';
import 'forget_password_screen.dart';
import 'register_screen.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller/login_screen_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginScreenController _loginController =
      Get.put(LoginScreenController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.height * 1,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset('assets/images/signinbg.png')),
              SizedBox(height: 2.h),
              const Text(
                "Welcome Back! ",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xff184C9A),
                    fontSize: 24),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: 95.w,
                height: 5.5.h,
                child: TextFormField(
                  controller: _loginController.emailController,
                  focusNode: _loginController.emailFocus,
                  decoration: InputDecoration(
                    hintText: 'Email',
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
                height: 5.5.h,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return TextFormField(
                      controller: _loginController.passwordController,
                      focusNode: _loginController.passwordFocus,
                      decoration: InputDecoration(
                        hintText: 'Password ',
                        suffixIcon: IconButton(
                          onPressed: () {
                            _loginController.toggleShowPassword();
                            setState(() {}); // Force a rebuild
                          },
                          icon: Icon(
                            _loginController.showPassword.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
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
                      obscureText: !_loginController.showPassword.value,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => ForgetPasswordScreen());
                      },
                      child: const Text(
                        "Forgot Password?",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF736868)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              Obx(() => _loginController.isLoading.value
                  ? const CircularProgressIndicator()
                  : customButton(
                      'LOGIN',
                      () {
                        _loginController.signInWithEmailAndPassword();
                        // _loginController.sendOtp();
                      },
                    )),
              SizedBox(
                height: 3.h,
              ),
              const Text('--------------- or ---------------'),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: () => _loginController.signInWithGoogle(),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: SizedBox(
                    width: 15.w,
                    height: 15.w,
                    child: Center(
                      child: Image.asset(
                        'assets/images/google image.png', // Replace with your image path
                        height: 12.w, // Adjust the image size as needed
                        width: 12.w,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text: "Don’t  have an Account!\t\t\t",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff736868),
                  ),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff184C9A),
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle the onTap event for "Sign Up"
                          Get.to(() => SignUpScreen());
                        },
                    ),
                  ],
                ),
              ),
            ]),
          )),
    );
  }
}
