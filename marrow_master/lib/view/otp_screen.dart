// import 'package:automated_bone_marrow_cell_classification_system/controller/auth_controller/login_screen_controller.dart';
// import 'package:automated_bone_marrow_cell_classification_system/view/home_screen/home_main_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'auth_screen/auth_screen_component/custom_button.dart';

// class OtpScreen extends StatefulWidget {
//   const OtpScreen({super.key});

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   LoginScreenController authService = LoginScreenController();
//   TextEditingController otpController = TextEditingController();

//   void _signInWithOTP() async {
//     // Replace with the actual verificationId obtained from the OTP sent to the user
//     String verificationId = Get.arguments as String;

//     UserCredential? userCredential = await authService.(
//         verificationId, otpController.text.trim());

//     if (userCredential != null) {
//       // Successfully signed in
//       Get.to(() => HomeMainScreen());
//       // Navigate to the next screen or perform other actions
//     } else {
//       // Sign in failed
//       Get.snackbar(
//           "Error", 'Incorrect Otp entered please Enter the Correct OTP');
//       // Show an error message to the user
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Colors.blue,
//           centerTitle: true,
//           title: const Text('OTP SCREEN')),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SizedBox(height: 5.h),
//           SizedBox(
//             width: 95.w,
//             child: TextField(
//               controller: otpController,
//               keyboardType: TextInputType.number,
//               maxLength: 6,
//               decoration: const InputDecoration(
//                 labelText: 'Enter OTP',
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           customButton(
//             'Login',
//             () {
//               // _loginController.signInWithEmailAndPassword();
//               _signInWithOTP();
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
