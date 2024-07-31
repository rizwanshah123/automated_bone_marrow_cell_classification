import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../controller/home_main_controller/home_screens_controller/home_controller.dart';
import 'home_screen_component/upload_buttom.dart';
import 'result_screen/result_screen.dart';

class HomeScreen extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff184C9A),
          elevation: 3,
          leading: const SizedBox.shrink(),
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
            ),
          ),
          title: const Text(
            'Marrow Master',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Container(
          height: 100.h,
          width: 100.w,
          color: const Color.fromARGB(255, 237, 234, 234),
          child: Obx(
            () => _homeController.isLoading.value
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Color(0xff184C9A),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Processing...'),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(height: 5.h),
                      SizedBox(
                        height: 20.h,
                        child: Image.asset(
                          'assets/images/microscope.png',
                          height: 27.h,
                          width: 100.w,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Unlocking Cell Secrets, One Image at a Time',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 15, 75, 164),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      InkWell(
                        onTap: () =>
                            _homeController.pickImage(ImageSource.camera),
                        child: uploadButton(
                          'assets/images/camera.png',
                          'Capture Image From Camera',
                          7.w,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      InkWell(
                        onTap: () async {
                          await _homeController.pickImage(ImageSource.gallery);
                        },
                        child: uploadButton(
                          'assets/images/gallery.png',
                          'Upload Image From Gallery',
                          10.w,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
