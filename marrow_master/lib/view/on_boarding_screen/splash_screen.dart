
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import 'onBoard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(() => const OnBoradingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: 100.h,
            width: 100.w,
            child: Column(children: [
              SizedBox(height: 28.h),
              Image.asset('assets/images/icon.png'),
              SizedBox(height: 2.h),
              const Text('Marrow Master',
                  style: TextStyle(
                    color: Color(0xff184C9A),
                    wordSpacing: 3,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  )),
              const Text(
                  'Experience the Future of Cell Classification on Your Device',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff5063BF),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ))
            ])));
  }
}
