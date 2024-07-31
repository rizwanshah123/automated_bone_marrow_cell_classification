import 'dart:io';

import 'package:flutter/material.dart';
import 'package:marrow_master/view/home_screen/home_main_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../home_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;

    final String name = args['name'];
    final String description = args['description'];
    final String imagePath = args['image'];
    final bool check = args['check'];

    return SafeArea(
      child: Scaffold(
          //  appBar:AppBar(
          //   title:Text("Result",

          //   )
          //  )
          body: Container(
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 252, 243, 243),
        ),
        child: Column(children: [
          // SizedBox(height: 5.h),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xff184C9A),
                border: Border.all(
                  width: 5,
                  color: const Color(0xff184C9A),
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                )),
            child: Row(children: [
              IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 3.h),
                  onPressed: () => Get.to(() => const HomeMainScreen())),
              SizedBox(width: 32.w),
              const Expanded(
                child: Text("Result",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1)),
              )
            ]),
          ),
          SizedBox(height: 1.h),
          SizedBox(
              height: 30.h,
              width: 100.w,
              // padding: const EdgeInsets.all(15),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(20),
              //   border: Border.all(color: const Color(0xff184C9A), width: 5),
              // ),
              child: ClipRRect(
                  // borderRadius: BorderRadius.circular(10),
                  child: check
                      ? Image.file(
                          File(imagePath),
                          fit: BoxFit.fitWidth,
                        )
                      : Image.network(imagePath, fit: BoxFit.fitWidth))),
          SizedBox(
            height: 3.h,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(name,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1)),
          ),
          //    SizedBox(height: 2.h),
          const Divider(thickness: .5, color: Colors.grey),
          Expanded(
            child: SizedBox(
                width: 100.w,
                // decoration: BoxDecoration(
                //     border: Border.all(
                //       width: 5,
                //       color: const Color(0xff184C9A),
                //     ),
                //     borderRadius: const BorderRadius.only(
                //       topLeft: Radius.circular(40),
                //       topRight: Radius.circular(40),
                //     )),
                child: Column(
                  children: [
                    // SizedBox(height: 2.h),
                    // const Text(
                    //   "Description",
                    //   style: TextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w600,
                    //       color: Colors.black,
                    //       letterSpacing: 1),
                    // ),
                    SizedBox(height: 1.h),
                    Expanded(
                      child: Container(
                          width: 100.w,
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          // decoration: BoxDecoration(
                          //     color: const Color.fromARGB(255, 252, 243, 243),
                          //     boxShadow: const [
                          //       BoxShadow(
                          //         color: Colors.grey, //New
                          //         blurRadius: 2.0,
                          //       )
                          //     ],
                          //     border:
                          //         Border.all(color: Colors.black.withOpacity(.2)),
                          //     borderRadius: BorderRadius.circular(10)),
                          child: Text(description,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ))),
                    )
                  ],
                )),
          )
        ]),
      )),
    );
  }
}
