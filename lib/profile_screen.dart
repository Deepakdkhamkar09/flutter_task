import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_task/controller/profile_controller.dart';
import 'package:flutter_task/step_one.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select Picture",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                ClipOval(
                  child: controller.profileImage != null
                      ? Image.file(
                          controller.profileImage!,
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/defoultProfile.png',
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      controller.showImagePickerDialog();
                    },
                    child: const CircleAvatar(
                      radius: 15,
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
            SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  isDense: true,
                  constraints: BoxConstraints(minHeight: 44),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 11, horizontal: 20),
                  hintText: 'Enter Name',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        style: BorderStyle.none,
                        width: 1,
                        color: Colors.black38),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: InkWell(
                onTap: () {
                  controller.handleSubmit();
                },
                child: Center(
                  child: Container(
                    // width: 152,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
