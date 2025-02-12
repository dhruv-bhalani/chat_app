import 'package:shared_preferences/shared_preferences.dart';

class ShrHelper {
  shareIntro() async {
    SharedPreferences shr = await SharedPreferences.getInstance();

    await shr.setBool('introShare', true);
  }

  Future<bool?> introStatus() async {
    SharedPreferences share = await SharedPreferences.getInstance();

    bool? status = share.getBool('introShare');
    return status;
  }
}
