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
            title: "Welcome",
            body: "Welcome to Chat App",
            image: Image.asset("assets/image/welcome2.png"),
          ),
          PageViewModel(
            title: "",
            body: "",
            image: Image.asset('assets/image/welcome.png'),
          ),
        ],
        done: const Text('Done'),
        next: const Text('Next'),
        skip: const Text('Skip'),
        onDone: () {
          ShrHelper s = ShrHelper();
          s.shareIntro();
          Navigator.of(context).pushReplacementNamed('/login');
        },
        // onSkip: () {},
        showSkipButton: true,
      ),
    );
  }
}
