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
        (AuthService.authService.currentUser == null)
            ? Get.offNamed(Routes.welcome)
            : (AuthService.authService.currentUser != null)
                ? Get.offNamed(Routes.home)
                : Get.offNamed(Routes.login);
      },
    );
    return Scaffold(
      backgroundColor: const Color(0xfffbf7ed),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/gif/splanchnic.gif'),
          ],
        ),
      ),
    );
  }
}
