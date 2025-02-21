import 'dart:async';

import 'package:chat_app/routes/routes.dart';
import 'package:chat_app/services/euth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () {
        (AuthService.authServices.currentUser == null)
            ? Get.offNamed(Routes.welcome)
            : (AuthService.authServices.currentUser != null)
                ? Get.offNamed(Routes.home)
                : Get.offNamed(Routes.login);
      },
    );
    return Scaffold(
      backgroundColor: const Color(0xffe1f5ff),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset(
            'assets/image/logo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
