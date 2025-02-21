import 'package:chat_app/helper/sherHelper.dart';

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            decoration: const PageDecoration(pageColor: Color(0xffe1f5ff)),
            title: "Welcome",
            body: "Welcome to Chat App",
            image: Image.asset(
              "assets/image/welcome2.png",
              fit: BoxFit.cover,
            ),
          ),
          PageViewModel(
            decoration: const PageDecoration(pageColor: Color(0xffe1f5ff)),
            title: "Chat with your friends",
            body: "Enjoy chat with your friends",
            image: Image.asset('assets/image/welcome.png'),
          ),
        ],
        done: const Text(
          'Done',
          style: TextStyle(color: Colors.black),
        ),
        next: const Text(
          'Next',
          style: TextStyle(color: Colors.black),
        ),
        skip: const Text(
          'Skip',
          style: TextStyle(color: Colors.black),
        ),
        onDone: () {
          ShrHelper s = ShrHelper();
          s.shareIntro();
          Navigator.of(context).pushReplacementNamed('/login');
        },
        // onSkip: () {},
        showSkipButton: true,
        globalBackgroundColor: const Color(0xffe1f5ff),
      ),
    );
  }
}
