import 'package:get/get.dart';

class DocumentController extends GetxController {
  bool isLoding = false;

  setLoading(bool val) {
    isLoding = val;
    update();
  }

  List DocumentsData = [];
  getDocumentsData(data) {
    DocumentsData = data;
    print(DocumentsData);
  }
}
