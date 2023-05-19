import 'package:_uaw/Models/usermodel.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static userModel user = userModel();

  void User(userModel data) {
    user = data;
    update();
  }
}
