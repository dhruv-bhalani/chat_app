import 'package:chat_app/services/euth_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Future<void> singOut() async {
    await AuthService.authServices.logOut();
  }
}
