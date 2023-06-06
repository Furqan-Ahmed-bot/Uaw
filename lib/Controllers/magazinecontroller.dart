import 'package:get/get.dart';

class MagazineController extends GetxController {
  bool isLoding = false;

  setLoading(bool val) {
    isLoding = val;
    update();
  }

  List MagzineData = [];
  getMagzinesData(data) {
    MagzineData = data;
    print(MagzineData);
  }
}
