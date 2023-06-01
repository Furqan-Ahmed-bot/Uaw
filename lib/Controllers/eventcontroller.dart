// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:get/get.dart';

class EventController extends GetxController {
  bool isLoding = false;

  setLoading(bool val) {
    isLoding = val;
    update();
  }

  List EventsData = [];
  getEventsData(data) {
    EventsData = data;
    print(EventsData);
  }

  List MyEvents = [];
  getMyEvents(data) {
    MyEvents = data;
    print(MyEvents);
  }
}
