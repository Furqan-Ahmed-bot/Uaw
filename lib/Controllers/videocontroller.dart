import 'package:get/get.dart';

class VideoController extends GetxController {
  bool isLoding = false;

  setLoading(bool val) {
    isLoding = val;
    update();
  }

  List VideoData = [];
  getvideoData(data) {
    VideoData = data;
    print(VideoData);
  }
}
