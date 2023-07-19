import 'package:get/get.dart';

class NotificationController extends GetxController {
  bool isLoding = false;

  setLoading(bool val) {
    isLoding = val;
    update();
  }

  List NotificationData = [];
  List NotificationLength = [];
  getNotificationsData(data) {
    NotificationData = data;
    NotificationLength = data;
    print(NotificationData);
  }
}
