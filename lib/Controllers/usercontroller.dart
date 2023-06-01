import 'package:_uaw/Models/usermodel.dart';
import 'package:get/get.dart';

import '../Models/eventmodel.dart';

class UserController extends GetxController {
  static userModel user = userModel();
  static EventModel event = EventModel();

  bool isLoding = false;

  setLoading(bool val) {
    isLoding = val;
    update();
  }

  void User(userModel data) {
    user = data;
    update();
  }

  void Events(EventModel data) {
    event = data;
    update();
  }
}
