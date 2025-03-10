import 'package:chat_app/controllers/login_controller.dart';
import 'package:chat_app/helper/extension.dart';
import 'package:chat_app/helper/extentions.dart';
import 'package:chat_app/routes/routes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var loginKey = GlobalKey<FormState>();

    var controller = Get.put(LoginController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffe1f5ff),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 250,
              width: 250,
              child: Image(
                image: AssetImage("assets/image/login.png"),
                fit: BoxFit.cover,
              ),
            ),
            20.h,
            Form(
              key: loginKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  10.h,
                  TextFormField(
                    controller: emailController,
                    validator: (value) => value!.isEmpty
                        ? "required email"
                        : (!value.isVerifyEmail())
                            ? "email is not valid"
                            : null,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(14),
                        ),
                      ),
                      hintText: 'Email',
                    ),
                  ),
                  10.h,
                  const Text(
                    'Password',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  10.h,
                  Obx(
                    () {
                      return TextFormField(
                        obscureText: controller.isPasswordVisible.value,
                        controller: passwordController,
                        validator: (value) =>
                            value!.isEmpty ? "required password" : null,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.changePasswordVisibility();
                            },
                            icon: Icon(controller.isPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(14),
                            ),
                          ),
                          hintText: 'Password',
                        ),
                      );
                    },
                  ),
                  const Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            10.h,
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (loginKey.currentState!.validate()) {
                  controller.loginNewUser(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                }
              },
              child: const Text('Login'),
            ),
            10.h,
            OutlinedButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Get.offNamed(Routes.register);
              },
              child: const Text('Sign Up'),
            ),
            30.h,
            const Text(
              "Or continue with",
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
            10.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.googleLogin();
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/image/google.png"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // controller.anonymousLogin();
                  },
                  child: const CircleAvatar(
                    radius: 23,
                    backgroundImage: AssetImage(
                      "assets/image/facebook.png",
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // controller.anonymousLogin();
                  },
                  child: const CircleAvatar(
                    radius: 23,
                    backgroundImage: AssetImage(
                      "assets/image/github.png",
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.anonymousLogin();
                  },
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xffe1f5ff),
                    backgroundImage: AssetImage(
                      "assets/image/guest.png",
                    ),
                  ),
                ),
              ],
            ),
            5.h,
            // Text.rich(
            //   TextSpan(
            //     children: [
            //       const TextSpan(
            //         text: 'Don\'t have an account? ',
            //         style: TextStyle(
            //           color: Colors.black,
            //         ),
            //       ),
            //       TextSpan(
            //         text: 'Sign Up',
            //         recognizer: TapGestureRecognizer()
            //           ..onTap = () {
            //             Get.offNamed(Routes.register);
            //           },
            //         style: const TextStyle(
            //           color: Colors.blue,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
