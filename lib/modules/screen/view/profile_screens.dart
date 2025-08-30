import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/modules/screen/controller/auth/auth_controller.dart';
import 'package:medical_app/modules/screen/controller/profile_controller.dart';
import 'package:medical_app/widgets/logout_button.dart';

class ProfileScreens extends GetView<ProfileController> {
  ProfileScreens({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: LogOutButton(
          text: "Sign Out",
          onPressed: () => authController.signOut(),
        ),
      ),
    );
  }
}
