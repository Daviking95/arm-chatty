
import 'firebase_pn.dart';

getDeviceToken() async {
  String? token = await LocalNotificationService.getToken();

  return token!;
}