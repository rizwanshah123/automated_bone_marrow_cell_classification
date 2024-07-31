import 'package:flutter/material.dart';
import 'package:marrow_master/view/home_screen/home_main_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../auth_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoradingScreen extends StatelessWidget {
  const OnBoradingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: 100.h,
            width: 100.w,
            child: Column(children: [
              SizedBox(height: 15.h),
              Image.asset('assets/images/icon.png'),
              SizedBox(height: 2.h),
              const Text('Welcome To',
                  style: TextStyle(
                    wordSpacing: 3,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  )),
              const Text('Marrow Master',
                  style: TextStyle(
                    color: Color(0xff184C9A),
                    wordSpacing: 3,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  )),
              const Text('Explore Automated Cell Classification with Ease',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  )),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
                  if (isLoggedIn) {
                    Get.offAll(() => const HomeMainScreen());
                  } else {
                    Get.offAll(() => LoginScreen());
                  }
                },
                child: Container(
                    width: 80.w,
                    height: 6.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color(0xff184C9A)),
                    child: const Text('Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ))),
              )
            ])));
  }
}
