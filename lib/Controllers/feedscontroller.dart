import 'package:get/get.dart';

class feedsController extends GetxController {
  bool isloading = false;

  setLoading(bool val) {
    isloading = val;
    update();
  }

  List AllFeeds = [];
  List feedsData = [];
  getFeeds(data) {
    AllFeeds = data;
    feedsData = data;
    print(feedsData);
  }

  // void setLoading(bool bool) {}
}
