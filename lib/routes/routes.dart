import 'package:chat_app/screens/auth/loginScreen/view/loginscreen.dart';
import 'package:chat_app/screens/auth/registerScreen/view/registerScreen.dart';
import 'package:chat_app/screens/chat/view/chat.dart';
import 'package:chat_app/screens/home/view/home.dart';
import 'package:chat_app/screens/splash/splashscreen.dart';
import 'package:chat_app/screens/welcome/welcome.dart';

import 'package:get/get.dart';

class Routes {
  static const String splesh = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register';
  static const String chat = '/chat';

  static List<GetPage> page = [
    GetPage(
        name: splesh,
        page: () => const Splashscreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: welcome,
        page: () => const Welcome(),
        transition: Transition.rightToLeft),
    GetPage(
        name: login,
        page: () => const LoginScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: register,
        page: () => const RegisterScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: home,
        page: () => const Home(),
        transition: Transition.rightToLeft),
    GetPage(
      name: chat,
      page: () => const Chat(),
      transition: Transition.rightToLeft,
    ),
  ];
}
