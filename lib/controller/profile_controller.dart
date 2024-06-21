import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_task/step_one.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileController extends GetxController {
  File? profileImage;
  TextEditingController nameController = TextEditingController();

  void handleSubmit() {
    if (profileImage != null && nameController.text.isNotEmpty) {
      Get.to(const StepsScreen());
    } else {
      Get.snackbar("Error", "Please fill all the fields",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    // Implement your login logic here
  }

  showImagePickerDialog() {
    Get.defaultDialog(
      title: 'Choose an option',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: () {
              Get.back();
              pickImage(ImageSource.gallery);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              Get.back();
              pickImage(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      update(); // Trigger UI update
    }
  }
}
