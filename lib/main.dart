import 'dart:developer';

import 'package:chat_app/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String? token = await FirebaseMessaging.instance.getToken();

  log("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
  log("$token");
  log("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      getPages: Routes.page,
    );
  }
}
// cupertino_icons: ^1.0.8
