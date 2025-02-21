import 'dart:io';

import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/routes/routes.dart';
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

  Future<void> registerNewUser(
      {required String email,
      required String password,
      required String username,
      required String image}) async {
    String msg = await AuthService.authServices
        .registerUser(email: email, password: password);
    if (msg == "Success") {
      Get.snackbar("Success", msg);

      FireStoreService.service.addUser(
        user: UserModel(
          uid: AuthService.authServices.currentUser?.uid ?? "",
          name: username,
          email: email,
          phone: "",
          password: password,
          image: image,
          token: await FirebaseMessaging.instance.getToken() ?? "",
        ),
      );

      Get.offNamed(Routes.login);
      update();
    } else {
      Get.snackbar("Error", msg);
      update();
    }
    update();
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
