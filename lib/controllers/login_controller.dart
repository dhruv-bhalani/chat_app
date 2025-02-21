import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/routes/routes.dart';
import 'package:chat_app/services/euth_service.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class LoginController extends GetxController {
  RxBool isPasswordVisible = false.obs;

  void changePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> loginNewUser(
      {required String email, required String password}) async {
    var msg = await AuthService.authServices.loginUser(
      email: email,
      password: password,
    );
    if (msg == "Success") {
      Get.offNamed(Routes.home);

      Get.snackbar("Success", msg);
    } else {
      Get.snackbar("Error", msg);
    }
  }

  Future<void> googleLogin() async {
    String msg = await AuthService.authServices.loginWithGoogle();

    if (msg == 'Success') {
      Get.offNamed(Routes.home);
      var user = AuthService.authServices.currentUser;
      if (user != null) {
        await FireStoreService.service.addUser(
          user: UserModel(
            uid: user.uid,
            name: user.displayName ?? "",
            email: user.email ?? "",
            phone: "",
            password: "",
            image: user.photoURL ?? "",
            token: await FirebaseMessaging.instance.getToken() ?? "",
          ),
        );
      }
      Get.snackbar("Success", msg);
    } else {
      Get.snackbar("Error", msg);
    }
  }

  void anonymousLogin() async {
    User? msg = await AuthService.authServices.anonymousLogin();
    if (msg != null) {
      Get.offNamed(Routes.home);
      Get.snackbar(
        "login success",
        msg.email ?? "",
      );
    } else {
      Get.snackbar(
        "Error",
        msg?.email ?? "",
      );
    }
  }
}
