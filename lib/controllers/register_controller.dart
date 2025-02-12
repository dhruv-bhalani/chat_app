import 'dart:io';

import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/euth_service.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class RegisterController extends GetxController {
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  File? image;

  void changePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void changeConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> registerNewUser({
    required String email,
    required String password,
    required String username,
    required String image,
  }) async {
    String msg = await AuthService.authService.registerUser(
      email: email,
      password: password,
    );
    if (msg == "Success") {
      Get.back();
      FireStoreService.fireStoreService.addUser(
        user: UserModel(
          uid: AuthService.authService.currentUser?.uid ?? "",
          name: username,
          email: email,
          password: password,
          image: image,
          token: await FirebaseMessaging.instance.getToken() ?? "",
        ),
      );
      toastification.show(
        title: const Text("Success"),
        description: const Text("Registration Success 😊"),
        autoCloseDuration: const Duration(
          seconds: 2,
        ),
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
      );
    } else {
      toastification.show(
        title: const Text("Error"),
        description: Text(msg),
        autoCloseDuration: const Duration(
          seconds: 2,
        ),
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
      );
    }
  }

  Future<void> pickUserImage() async {
    ImagePicker picker = ImagePicker();
    XFile? xFile = await picker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
      image = File(xFile.path);
    }
    update();
  }
}
