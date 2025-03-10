import 'package:chat_app/controllers/login_controller.dart';
import 'package:chat_app/controllers/register_controller.dart';
import 'package:chat_app/helper/extension.dart';
import 'package:chat_app/helper/extentions.dart';
import 'package:chat_app/routes/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController cPasswordController = TextEditingController();
    TextEditingController usernameController = TextEditingController();

    var registerKey = GlobalKey<FormState>();
    var controllers = Get.put(LoginController());
    var controller = Get.put(RegisterController());
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffe1f5ff),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 70, left: 16, right: 16, bottom: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 170,
                width: 170,
                child: Image(
                  image: AssetImage(
                    "assets/image/sign.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              40.h,
              Form(
                key: registerKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Username',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    10.h,
                    TextFormField(
                      controller: usernameController,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter Username' : null,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    10.h,
                    const Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    10.h,
                    TextFormField(
                      controller: emailController,
                      validator: (value) => value!.isEmpty
                          ? "Required Email"
                          : (!value.isVerifyEmail())
                              ? "Email is not valid"
                              : null,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    10.h,
                    const Text(
                      'Password',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    10.h,
                    Obx(
                      () {
                        return TextFormField(
                          obscureText: controller.isPasswordVisible.value,
                          controller: passwordController,
                          validator: (value) =>
                              value!.isEmpty ? "Required Password" : null,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  controller.changePasswordVisibility();
                                },
                                icon: Icon(controller.isPasswordVisible.value
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off)),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(14),
                              ),
                            ),
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(14),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(14),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    10.h,
                    const Text(
                      'Confirm Password',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    10.h,
                    Obx(
                      () {
                        return TextFormField(
                          obscureText:
                              controller.isConfirmPasswordVisible.value,
                          controller: cPasswordController,
                          validator: (value) => value!.isEmpty
                              ? "Required Confirm Password"
                              : null,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  controller.changeConfirmPasswordVisibility();
                                },
                                icon: Icon(
                                    controller.isConfirmPasswordVisible.value
                                        ? Icons.remove_red_eye
                                        : Icons.visibility_off)),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(14),
                              ),
                            ),
                            hintText: 'Confirm Password',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(14),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(14),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              30.h,
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
                onPressed: () async {
                  if (registerKey.currentState!.validate()) {
                    String username = usernameController.text.trim();
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();
                    String cPassword = cPasswordController.text.trim();
                    if (password == cPassword) {
                      await controller.registerNewUser(
                          email: email,
                          password: password,
                          username: username,
                          image: "");
                    } else {
                      Get.snackbar("Error", "Password doesn't match");
                    }
                  }
                },
                child: const Text('Sign Up'),
              ),
              45.h,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      controllers.googleLogin();
                    },
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("assets/image/google.png"),
                    ),
                  ),
                  // 15.w,
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
                  // 15.w,
                  GestureDetector(
                    onTap: () {
                      controllers.anonymousLogin();
                    },
                    child: const CircleAvatar(
                      radius: 32,
                      backgroundColor: Color(0xffe1f5ff),
                      backgroundImage: AssetImage(
                        "assets/image/guest.png",
                      ),
                    ),
                  ),
                ],
              ),
              40.h,
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'Login Now',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.offNamed(Routes.login);
                        },
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
