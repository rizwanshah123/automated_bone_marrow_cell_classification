import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marrow_master/view/auth_screen/auth_screen_component/custom_button.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/home_main_controller/setting_screen_controllers/profile_screen_controller.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController _profileController = Get.put(ProfileController());

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.white,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff184C9A),
        elevation: 0.0,
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            SizedBox(height: 8.h),
            Stack(
              children: [
                Obx(() => CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          _profileController.profileImageUrl.value.isNotEmpty
                              ? NetworkImage(
                                  _profileController.profileImageUrl.value)
                              : const NetworkImage(
                                  'https://via.placeholder.com/150'),
                    )),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      Get.defaultDialog(
                        title: "Select Image",
                        content: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera),
                              title: const Text("Camera"),
                              onTap: () {
                                _profileController
                                    .pickImage(ImageSource.camera);
                                Get.back();
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.image),
                              title: const Text("Gallery"),
                              onTap: () {
                                _profileController
                                    .pickImage(ImageSource.gallery);
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            SizedBox(
              width: 95.w,
              height: 5.5.h,
              child: TextFormField(
                controller: _profileController.fullNameController,
                onChanged: (value) => _profileController.fullName.value = value,
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
            const SizedBox(height: 20),
            SizedBox(
              width: 95.w,
              height: 5.5.h,
              child: TextFormField(
                controller: _profileController.contactNoController,
                keyboardType: TextInputType.phone,
                onChanged: (value) =>
                    _profileController.contactNo.value = value,
                decoration: InputDecoration(
                  hintText: 'Contact No',
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
            const SizedBox(height: 20),
            SizedBox(
              width: 95.w,
              height: 5.5.h,
              child: TextFormField(
                controller: _profileController.professionController,
                onChanged: (value) =>
                    _profileController.profession.value = value,
                decoration: InputDecoration(
                  hintText: 'Profession',
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Gender: ",
                  style: TextStyle(fontSize: 12.sp),
                ),
                Obx(
                  () => Row(
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: _profileController.gender.value,
                        onChanged: (value) {
                          _profileController.gender.value = value!;
                        },
                      ),
                      Text(
                        'Male',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      Radio<String>(
                        value: 'Female',
                        groupValue: _profileController.gender.value,
                        onChanged: (value) {
                          _profileController.gender.value = value!;
                        },
                      ),
                      Text(
                        'Female',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      Radio<String>(
                        value: 'Other',
                        groupValue: _profileController.gender.value,
                        onChanged: (value) {
                          _profileController.gender.value = value!;
                        },
                      ),
                      Text(
                        'Other',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Obx(() => _profileController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : customButton("Update", () {
                    _profileController.updateUserProfile();
                  }))
          ],
        ),
      ),
    );
  }
}
