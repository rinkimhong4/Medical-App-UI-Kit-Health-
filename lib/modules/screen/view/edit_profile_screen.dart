import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/modules/screen/controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize text controllers with current values
    final usernameCtrl = TextEditingController(text: controller.username.value);
    final phoneCtrl = TextEditingController(text: controller.phoneNumber.value);
    final ageCtrl = TextEditingController(text: controller.age.value);
    final addressCtrl = TextEditingController(text: controller.address.value);
    final genderCtrl = TextEditingController(text: controller.gender.value);

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: usernameCtrl,
              decoration: const InputDecoration(labelText: "Username"),
              onChanged: (val) => controller.username.value = val,
            ),
            TextField(
              controller: phoneCtrl,
              decoration: const InputDecoration(labelText: "Phone Number"),
              onChanged: (val) => controller.phoneNumber.value = val,
            ),
            TextField(
              controller: ageCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Age"),
              onChanged: (val) => controller.age.value = val,
            ),
            TextField(
              controller: addressCtrl,
              decoration: const InputDecoration(labelText: "Address"),
              onChanged: (val) => controller.address.value = val,
            ),
            TextField(
              controller: genderCtrl,
              decoration: const InputDecoration(labelText: "Gender"),
              onChanged: (val) => controller.gender.value = val,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.updateProfile(
                  newUsername: controller.username.value,
                  newPhoneNumber: controller.phoneNumber.value,
                  newAge: controller.age.value,
                  newAddress: controller.address.value,
                  newGender: controller.gender.value,
                );
              },
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
