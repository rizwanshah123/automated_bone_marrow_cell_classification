import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../controller/home_main_controller/setting_screen_controllers/delete_account_controller.dart';
import '../../../controller/home_main_controller/setting_screen_controllers/logout_controller.dart';
import '../../auth_screen/change_password_screen.dart';
import 'profile_screen.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final LogoutController _logoutController = Get.put(LogoutController());
  final DeleteAccountController deleteAccountController =
      Get.put(DeleteAccountController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),
            leading: const SizedBox.shrink(),
            title: const Text(
              'Setting',
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
                  SizedBox(
                    height: 3.h,
                  ),
                  _profileComponent(
                      'assets/images/changePassword.png',
                      'Change Password',
                      () => Get.to(const ChangePasswordScreen())),
                  _profileComponent('assets/images/profile.png', 'Profile', () {
                    Get.to(() => ProfileScreen());
                  }),
                  _profileComponent(
                      'assets/images/deleteUser.png', 'Delete Account', () {
                    deleteAccountController.deleteAccount();
                  }),
                  _profileComponent('assets/images/logout.png', 'Logout',
                      () => _logoutController.logout()),
                ],
              ))),
    );
  }
}

Widget _profileComponent(String img, String name, Function fun) {
  return Container(
    margin: const EdgeInsets.only(
      bottom: 20,
      left: 15,
      right: 15,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xff184C9A), width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      leading: Image.asset(img, height: 25, width: 25),
      title: Text(name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          )),
      trailing: const Icon(Icons.arrow_forward_ios,
          color: Color(0xff184C9A), size: 24),
      onTap: () => fun(),
    ),
  );
}
