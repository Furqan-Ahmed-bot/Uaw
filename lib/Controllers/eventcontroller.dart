import 'package:get/get.dart';

class EventController extends GetxController {
  bool isLoding = false;

  setLoading(bool val) {
    isLoding = val;
    update();
  }

  List AllEvents = [];
  List EventsData = [];
  getEventsData(data) {
    AllEvents = data;
    EventsData = data;
    print(EventsData);
  }

  List MyEvents = [];
  getMyEvents(data) {
    MyEvents = data;
    print(MyEvents);
  }
}
