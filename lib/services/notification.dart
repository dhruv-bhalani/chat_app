import 'package:permission_handler/permission_handler.dart';

Future<void> permissions() async {
  PermissionStatus permissionStatus = await Permission.notification.request();

  if (permissionStatus.isDenied) {
    await permissions();
  }
}
