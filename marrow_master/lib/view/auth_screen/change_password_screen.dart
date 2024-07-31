import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool show = true;
  bool show1 = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => {Navigator.pop(context)},
                icon: const Icon(Icons.arrow_back, color: Colors.white)),
            title: const Text(
              'Change Password',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xff184C9A),
            elevation: 0.0,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            margin: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //const SizedBox(height:50),
                Lottie.asset(
                  'assets/images/forget.json',
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 1,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.050),
                SizedBox(
                  height: 5.5.h,
                  width: 95.w,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                    obscureText: show,
                    decoration: InputDecoration(
                      hintText: 'Old Password',
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.020),
                SizedBox(
                  height: 5.5.h,
                  width: 95.w,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                    obscureText: show,
                    decoration: InputDecoration(
                      hintText: 'New Password',
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.020),
                SizedBox(
                  height: 5.5.h,
                  width: 95.w,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                    obscureText: show,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.060),
                GestureDetector(
                  onTap: () => {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.bottomSlide,
                      title: 'Password change Successfully',
                      btnOk: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * .05,
                          width: MediaQuery.of(context).size.width * .09,
                          decoration: BoxDecoration(
                            color: const Color(0xff184C9A),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Ok',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montsesrrat'),
                          ),
                        ),
                      ),
                    )..show()
                  },
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 6.h,
                      width: 95.w,
                      decoration: BoxDecoration(
                          color: const Color(0xff184C9A),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Change Password',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
