// // ignore_for_file: prefer_const_constructors

// import 'package:_uaw/Global.dart';
// import 'package:_uaw/Helpers.dart';
// import 'package:_uaw/HomeScreens/NewsAndEventDetails.dart';
// import 'package:_uaw/HomeScreens/SelectedDateEventDetails.dart';
// import 'package:_uaw/HomeScreens/SelectedDateEvents.dart';
// import 'package:_uaw/HomeScreens/home.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';

// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/intl.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// import 'package:intl/intl.dart' as intl;

// import '../Auth/APIService/API.dart';
// import '../Controller.dart';
// import '../Controllers/eventcontroller.dart';
// import 'Drawer.dart';
// import 'NavBar.dart';

// class NewsAndEventsScreen extends StatefulWidget {
//   final String value;
//   const NewsAndEventsScreen({super.key, required this.value});

//   @override
//   State<NewsAndEventsScreen> createState() => _NewsAndEventsScreenState();
// }

// class _NewsAndEventsScreenState extends State<NewsAndEventsScreen> {
//   final bottomcontroller = Get.put(BottomController());
//   final GlobalKey<ScaffoldState> _key = GlobalKey();
//   final CalendarFormat _calendarFormat = CalendarFormat.month;
//   final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn; // Can be toggled on/off by longpressing a date
//   final DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   DateTime? _rangeStart;
//   DateTime? _rangeEnd;
//   String _selectedDate = '';
//   String _dateCount = '';
//   String _range = '';
//   String _rangeCount = '';

//   var selectedvalue;
//   final kToday = DateTime.now();
//   final kFirstDay = DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);
//   final kLastDay = DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);
//   double pad = 23.0;
//   void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
//     setState(() {
//       if (args.value is PickerDateRange) {
//         _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
// // ignore: lines_longer_than_80_chars
//             ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
//       } else if (args.value is DateTime) {
//         _selectedDate = args.value.toString();
//       } else if (args.value is List<DateTime>) {
//         _dateCount = args.value.length.toString();
//       } else {
//         _rangeCount = args.value.length.toString();
//       }
//     });
//   }

//   void viewChanged(DateRangePickerViewChangedArgs args) {
//     final DateTime visibleStartDate = args.visibleDateRange.startDate!;
//     final DateTime visibleEndDate = args.visibleDateRange.endDate!;
//     final int totalVisibleDays = (visibleStartDate.difference(visibleEndDate).inDays);
//     final DateTime midDate = visibleStartDate.add(Duration(days: totalVisibleDays ~/ 2));
//     headerString = intl.DateFormat('MMMM yyyy').format(midDate).toString();
//     SchedulerBinding.instance.addPostFrameCallback((duration) {});
//   }

//   bool timezone = false;
//   final DateRangePickerController _controller = DateRangePickerController();
//   String headerString = '';

//   String now = DateFormat("yyyy-MM-dd").format(DateTime.now());
// //

//   final DateRangePickerController _dateController = DateRangePickerController();
//   String _date = "null";
//   void selectionChanged(DateRangePickerSelectionChangedArgs args) {
//     SchedulerBinding.instance.addPostFrameCallback((duration) {
//       setState(() {
//         _date = DateFormat('dd MMMM yyyy').format(args.value).toString();
//       });

//       Get.back();
//     });
//   }

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ApiService().Events(context);
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 1.sw,
//       height: 1.sh,
//       color: whitish,
//       child: Scaffold(
//         key: _key,
//         backgroundColor: transparentcolor,
//         appBar: AppBar(
//           backgroundColor: transparentcolor,
//           elevation: 0,
//           leadingWidth: 70,
//           leading: GestureDetector(
//             onTap: () {
//               Get.to(() => const DrawerScreen(), transition: Transition.leftToRight, duration: const Duration(milliseconds: 300));
//             },
//             child: Center(
//               child: Container(
//                 width: 55.w,
//                 height: 55.h,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: whitecolor,
//                 ),
//                 child: _date == "null"
//                     ? Image.asset(
//                         "assets/images/Group 1288@3x.png",
//                         scale: 2.5,
//                       )
//                     : Image.asset(
//                         "assets/images/Group 1430@3x.png",
//                         scale: 2.5,
//                       ),
//               ),
//             ),
//           ),
//           title: Hero(
//             transitionOnUserGestures: true,
//             tag: "newtag",
//             child: _date == "null"
//                 ? Text(
//                     "NEWS & EVENTS",
//                     style: textroboto18,
//                   )
//                 : Text(
//                     _date.toString(),
//                     style: textroboto18,
//                   ),
//           ),
//           centerTitle: true,
//           actions: [
//             GestureDetector(
//               onTap: () {
//                 showDialog(
//                     context: context,
//                     builder: (context) {
//                       return StatefulBuilder(builder: (BuildContext context, setState) {
//                         return AlertDialog(
//                             insetPadding: EdgeInsets.zero,
//                             scrollable: true,
//                             backgroundColor: const Color(0xff000000b8),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20.0.r),
//                             ),
//                             contentPadding: const EdgeInsets.all(0),
//                             actionsPadding: const EdgeInsets.all(0),
//                             actions: [
//                               Container(
//                                 width: 0.8.sw,
//                                 height: 0.56.sh,
//                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: const Color(0xffFFFFFF)),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () {
//                                             Get.back();
//                                           },
//                                           child: Container(
//                                             width: 35.w,
//                                             height: 35.h,
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.only(
//                                                 bottomLeft: Radius.circular(20.r),
//                                                 topRight: Radius.circular(20.r),
//                                               ),
//                                               color: bluishshade,
//                                             ),
//                                             child: const Icon(
//                                               Icons.close,
//                                               color: white,
//                                               size: 25,
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     10.verticalSpace,
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 0),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Container(
//                                             child: IconButton(
//                                               icon: const Icon(Icons.arrow_back_ios),
//                                               color: Colors.black,
//                                               iconSize: 20,
//                                               onPressed: () {
//                                                 setState(
//                                                   () {
//                                                     _dateController.backward!();
//                                                   },
//                                                 );
//                                               },
//                                             ),
//                                           ),
//                                           Container(
//                                             child: Text(headerString,
//                                                 textAlign: TextAlign.center,
//                                                 style: const TextStyle(
//                                                   fontSize: 25,
//                                                   color: Colors.black,
//                                                 )),
//                                           ),
//                                           Container(
//                                               child: IconButton(
//                                             icon: const Icon(
//                                               Icons.arrow_forward_ios,
//                                             ),
//                                             color: Colors.black,
//                                             iconSize: 20,
//                                             onPressed: () {
//                                               setState(() {
//                                                 _dateController.forward!();
//                                               });
//                                             },
//                                           )),
//                                         ],
//                                       ),
//                                     ),
//                                     Stack(
//                                       alignment: Alignment.center,
//                                       children: [
//                                         20.verticalSpace,
//                                         SfDateRangePicker(
//                                           controller: _dateController,
//                                           allowViewNavigation: true,

//                                           onSelectionChanged: selectionChanged,
//                                           initialSelectedDate: DateTime.now(),

//                                           //  (DateRangePickerSelectionChangedArgs args) {

//                                           //   // setState(
//                                           //   //   () {
//                                           //   //     selection = true;
//                                           //   //     selectedvalue = args;
//                                           //   //     // DateTime now = selectedvalue;
//                                           //   //     // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

//                                           //   //     print('Current Date ${selectedvalue}');
//                                           //   //   },
//                                           //   // );

//                                           //   // setState() {
//                                           //   //   selection = true;
//                                           //   // }

//                                           //   // bottomcontroller.navBarChange(1);

//                                           //   Get.to(() => SelectedDateEventDetailsScreen(),
//                                           //       duration: Duration(seconds: 1), transition: Transition.fadeIn);
//                                           // },

//                                           selectionColor: const Color(0xffEDEDED),
//                                           selectionTextStyle: const TextStyle(
//                                             color: Colors.black,
//                                           ),
//                                           backgroundColor: Colors.white,
//                                           view: DateRangePickerView.month,
//                                           headerHeight: 0,
//                                           onViewChanged: viewChanged,
//                                           monthCellStyle: DateRangePickerMonthCellStyle(
//                                             weekendTextStyle: const TextStyle(color: Colors.red),
//                                             todayCellDecoration: BoxDecoration(
//                                                 border: Border.all(
//                                               width: 1.w,
//                                               color: Colors.transparent,
//                                             )),
//                                             todayTextStyle: const TextStyle(
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.w500,
//                                               color: Color(0xffEDEDED),
//                                             ),
//                                             textStyle: const TextStyle(
//                                               fontWeight: FontWeight.w400,
//                                               fontSize: 15,
//                                               color: Colors.black,
//                                               backgroundColor: Colors.white,
//                                             ),
//                                           ),
//                                           monthViewSettings: const DateRangePickerMonthViewSettings(
//                                             firstDayOfWeek: DateTime.monday,
//                                             viewHeaderStyle: DateRangePickerViewHeaderStyle(
//                                               textStyle: TextStyle(
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ]);
//                       });
//                     });
//               },
//               child: Image.asset(
//                 "assets/images/Icon metro-calendar@3x.png",
//                 scale: 2.5,
//               ),
//             )
//           ],
//         ),
//         drawer: const DrawerScreen(),
//         body: GetBuilder<EventController>(builder: (eventController) {
//           return (eventController.isLoding
//               ? const Center(child: CircularProgressIndicator())
//               : ListView.builder(
//                   itemCount: eventController.EventsData.length,
//                   itemBuilder: (context, index) {
//                     return Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Get.to(
//                                 () => NewsAndEventsDetailsScreen(
//                                       name: eventController.EventsData[index]['user']['name'],
//                                       date: eventController.EventsData[index]['date'].toString(),
//                                       description: eventController.EventsData[index]['description'],
//                                       timee: eventController.EventsData[index]['date'].toString(),
//                                       title: eventController.EventsData[index]['title'],
//                                       location: eventController.EventsData[index]['location'].toString(),
//                                       eventimage: eventController.EventsData[index]['file'].length == 0
//                                           ? null
//                                           : eventController.EventsData[index]['file'][0]['file'],
//                                       eventid: eventController.EventsData[index]['_id'],
//                                     ),
//                                 duration: Duration(seconds: 1),
//                                 transition: Transition.fadeIn);
//                           },
//                           child: Container(
//                             width: 1.sw,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.r),
//                               color: white,
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 20.r),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   20.verticalSpace,
//                                   Row(
//                                     children: [
//                                       Container(
//                                         width: 60.h,
//                                         height: 60.h,
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           image: DecorationImage(
//                                             image: AssetImage(
//                                               "assets/images/Ellipse 68-1@3x.png",
//                                             ),
//                                             fit: BoxFit.fill,

//                                             //     NetworkImage(
//                                             //   "https://uaw-api.thesuitchstaging.com:3090/${eventController.EventsData[index]['file'][0]['file']}",
//                                             // ),
//                                           ),
//                                         ),
//                                       ),
//                                       10.horizontalSpace,
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             eventController.EventsData[index]['user']['name'],
//                                             style: txtstyleblue17,
//                                           ),
//                                           5.verticalSpace,
//                                           Text(
//                                             eventController.EventsData[index]['date'].toString(),
//                                             style: textroboto12,
//                                           ),
//                                         ],
//                                       ),
//                                       const Spacer(),
//                                       Image.asset(
//                                         "assets/images/Group 1333@3x.png",
//                                         scale: 3.5,
//                                       )
//                                     ],
//                                   ),
//                                   15.verticalSpace,
//                                   eventController.EventsData[index]['file'].length == 0
//                                       ? StaggeredGrid.count(
//                                           crossAxisCount: 3,
//                                           mainAxisSpacing: 5,
//                                           crossAxisSpacing: 5,
//                                           children: [
//                                             StaggeredGridTile.count(
//                                               crossAxisCellCount: 1,
//                                               mainAxisCellCount: 1,
//                                               child: Container(
//                                                 width: 115.w,
//                                                 height: 135.h,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.only(
//                                                     topLeft: Radius.circular(10.r),
//                                                   ),
//                                                   color: black,
//                                                   image:
//                                                       const DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
//                                                 ),
//                                               ),
//                                             ),
//                                             StaggeredGridTile.count(
//                                               crossAxisCellCount: 1,
//                                               mainAxisCellCount: 1,
//                                               child: Container(
//                                                 width: 115.w,
//                                                 height: 135.h,
//                                                 decoration: const BoxDecoration(
//                                                   image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
//                                                   color: black,
//                                                 ),
//                                               ),
//                                             ),
//                                             StaggeredGridTile.count(
//                                               crossAxisCellCount: 1,
//                                               mainAxisCellCount: 1,
//                                               child: Container(
//                                                 width: 115.w,
//                                                 height: 135.h,
//                                                 decoration: BoxDecoration(
//                                                   color: black,
//                                                   borderRadius: BorderRadius.only(
//                                                     topRight: Radius.circular(10.r),
//                                                   ),
//                                                   image:
//                                                       const DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
//                                                 ),
//                                               ),
//                                             ),
//                                             StaggeredGridTile.count(
//                                               crossAxisCellCount: 5,
//                                               mainAxisCellCount: 1,
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Container(
//                                                     width: 170.w,
//                                                     decoration: BoxDecoration(
//                                                       borderRadius: BorderRadius.only(
//                                                         bottomLeft: Radius.circular(10.r),
//                                                       ),
//                                                       color: black,
//                                                       image: const DecorationImage(
//                                                           image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     width: 170.w,
//                                                     decoration: BoxDecoration(
//                                                       borderRadius: BorderRadius.only(
//                                                         bottomRight: Radius.circular(10.r),
//                                                       ),
//                                                       color: black,
//                                                       image: const DecorationImage(
//                                                           image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       : Image(
//                                           image: NetworkImage(
//                                             "https://uaw-api.thesuitchstaging.com:3090/${eventController.EventsData[index]['file'][0]['file']}",
//                                           ),
//                                         ),
//                                   10.verticalSpace,
//                                   Row(
//                                     children: [
//                                       Text(
//                                         eventController.EventsData[index]['title'].toString(),
//                                         style: textroboto15,
//                                       ),
//                                     ],
//                                   ),
//                                   20.verticalSpace,
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   }));
//         }),
//       ),
//     );
//   }
// }

// class Newsandeventswidget extends StatelessWidget {
//   const Newsandeventswidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: 1.sw,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.r),
//             color: white,
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.r),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 20.verticalSpace,
//                 Row(
//                   children: [
//                     Container(
//                       width: 60.h,
//                       height: 60.h,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                           image: AssetImage(
//                             "assets/images/Ellipse 68@3x.png",
//                           ),
//                         ),
//                       ),
//                     ),
//                     10.horizontalSpace,
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Admin",
//                           style: txtstyleblue17,
//                         ),
//                         5.verticalSpace,
//                         Text(
//                           DateFormat(
//                             "MM-dd-yyyy",
//                           ).format(
//                             DateTime.now(),
//                           ),
//                           style: textroboto12,
//                         ),
//                       ],
//                     ),
//                     const Spacer(),
//                     Image.asset(
//                       "assets/images/Group 1333@3x.png",
//                       scale: 3.5,
//                     )
//                   ],
//                 ),
//                 15.verticalSpace,
//                 StaggeredGrid.count(
//                   crossAxisCount: 3,
//                   mainAxisSpacing: 5,
//                   crossAxisSpacing: 5,
//                   children: [
//                     StaggeredGridTile.count(
//                       crossAxisCellCount: 1,
//                       mainAxisCellCount: 1,
//                       child: Container(
//                         width: 115.w,
//                         height: 135.h,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(10.r),
//                           ),
//                           color: black,
//                           image: const DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
//                         ),
//                       ),
//                     ),
//                     StaggeredGridTile.count(
//                       crossAxisCellCount: 1,
//                       mainAxisCellCount: 1,
//                       child: Container(
//                         width: 115.w,
//                         height: 135.h,
//                         decoration: const BoxDecoration(
//                           image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
//                           color: black,
//                         ),
//                       ),
//                     ),
//                     StaggeredGridTile.count(
//                       crossAxisCellCount: 1,
//                       mainAxisCellCount: 1,
//                       child: Container(
//                         width: 115.w,
//                         height: 135.h,
//                         decoration: BoxDecoration(
//                           color: black,
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(10.r),
//                           ),
//                           image: const DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
//                         ),
//                       ),
//                     ),
//                     StaggeredGridTile.count(
//                       crossAxisCellCount: 5,
//                       mainAxisCellCount: 1,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: 170.w,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(10.r),
//                               ),
//                               color: black,
//                               image: const DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
//                             ),
//                           ),
//                           Container(
//                             width: 170.w,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                 bottomRight: Radius.circular(10.r),
//                               ),
//                               color: black,
//                               image: const DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 10.verticalSpace,
//                 Text(
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae vulputate velit. Nulla facilisi. Fusce interdum ornare arcu, quis",
//                   style: textroboto15,
//                 ),
//                 20.verticalSpace,
//               ],
//             ),
//           ),
//         ),
//         15.verticalSpace,
//       ],
//     );
//   }
// }
// ignore_for_file: prefer_const_constructors

import 'package:_uaw/Global.dart';
import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/NewsAndEventDetails.dart';
import 'package:_uaw/HomeScreens/SelectedDateEventDetails.dart';
import 'package:_uaw/HomeScreens/SelectedDateEvents.dart';
import 'package:_uaw/HomeScreens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart' as intl;

import '../Auth/APIService/API.dart';
import '../Controller.dart';
import '../Controllers/eventcontroller.dart';
import 'Drawer.dart';
import 'NavBar.dart';

class NewsAndEventsScreen extends StatefulWidget {
  final String value;
  const NewsAndEventsScreen({super.key, required this.value});

  @override
  State<NewsAndEventsScreen> createState() => _NewsAndEventsScreenState();
}

class _NewsAndEventsScreenState extends State<NewsAndEventsScreen> {
  final bottomcontroller = Get.put(BottomController());
  final eventController = Get.put(EventController());
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn; // Can be toggled on/off by longpressing a date
  final DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  List myEevents = [];
  List filteredEvents = [];
  bool showAll = false;

  var selectedvalue;
  final kToday = DateTime.now();
  final kFirstDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final kLastDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  double pad = 23.0;
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
// ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  void searchevent(query) {
    myEevents = eventController.AllEvents;
    print('MyEventsss $myEevents');
    if (query.isEmpty) {
      setState(() {
        eventController.EventsData = eventController.AllEvents;
      });
    } else {
      eventController.EventsData = myEevents.where((item) => (item['date'].toLowerCase()).contains(query)).toList();
    }
  }

  void viewChanged(DateRangePickerViewChangedArgs args) {
    final DateTime visibleStartDate = args.visibleDateRange.startDate!;
    final DateTime visibleEndDate = args.visibleDateRange.endDate!;
    final int totalVisibleDays = (visibleStartDate.difference(visibleEndDate).inDays);
    final DateTime midDate = visibleStartDate.add(Duration(days: totalVisibleDays ~/ 2));
    headerString = intl.DateFormat('MMMM yyyy').format(midDate).toString();
    SchedulerBinding.instance.addPostFrameCallback((duration) {});
  }

  bool timezone = false;
  final DateRangePickerController _controller = DateRangePickerController();
  String headerString = '';

  String now = DateFormat("yyyy-MM-dd").format(DateTime.now());
//

  final DateRangePickerController _dateController = DateRangePickerController();
  String _date = "null";
  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      setState(() {
        _date = DateFormat('dd M yyyy').format(args.value).toString();

        print('mydate is $_date');
        searchevent(_date);
        showAll = true;
      });

      Get.back();
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ApiService().Events(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      color: whitish,
      child: Scaffold(
        key: _key,
        backgroundColor: transparentcolor,
        appBar: AppBar(
          backgroundColor: transparentcolor,
          elevation: 0,
          leadingWidth: 70,
          leading: GestureDetector(
            onTap: () {
              Get.to(() => const DrawerScreen(), transition: Transition.leftToRight, duration: const Duration(milliseconds: 300));
            },
            child: Center(
              child: Container(
                width: 55.w,
                height: 55.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: whitecolor,
                ),
                child: _date == "null"
                    ? Image.asset(
                        "assets/images/Group 1288@3x.png",
                        scale: 2.5,
                      )
                    : Image.asset(
                        "assets/images/Group 1430@3x.png",
                        scale: 2.5,
                      ),
              ),
            ),
          ),
          title: Hero(
            transitionOnUserGestures: true,
            tag: "newtag",
            child: showAll == false
                ? Text(
                    "NEWS & EVENTS",
                    style: textroboto18,
                  )
                : Text(
                    _date.toString(),
                    style: textroboto18,
                  ),
          ),
          centerTitle: true,
          actions: [
            showAll == true
                ? Padding(
                    padding: const EdgeInsets.only(top: 15, right: 15),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          searchevent('');
                        });

                        showAll = false;
                      },
                      child: Text(
                        'All',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                  )
                : Container(),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (BuildContext context, setState) {
                        return AlertDialog(
                            insetPadding: EdgeInsets.zero,
                            scrollable: true,
                            backgroundColor: const Color(0xff000000b8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0.r),
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            actionsPadding: const EdgeInsets.all(0),
                            actions: [
                              Container(
                                width: 0.8.sw,
                                height: 0.56.sh,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: const Color(0xffFFFFFF)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            width: 35.w,
                                            height: 35.h,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20.r),
                                                topRight: Radius.circular(20.r),
                                              ),
                                              color: bluishshade,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: white,
                                              size: 25,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    10.verticalSpace,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: IconButton(
                                              icon: const Icon(Icons.arrow_back_ios),
                                              color: Colors.black,
                                              iconSize: 20,
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    _dateController.backward!();
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Container(
                                            child: Text(headerString,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          Container(
                                              child: IconButton(
                                            icon: const Icon(
                                              Icons.arrow_forward_ios,
                                            ),
                                            color: Colors.black,
                                            iconSize: 20,
                                            onPressed: () {
                                              setState(() {
                                                _dateController.forward!();
                                              });
                                            },
                                          )),
                                        ],
                                      ),
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        20.verticalSpace,
                                        SfDateRangePicker(
                                          view: DateRangePickerView.month,
                                          controller: _dateController,
                                          allowViewNavigation: true,
                                          onSelectionChanged: selectionChanged,
                                          initialSelectedDate: DateTime.now(),
                                          selectionColor: const Color(0xffEDEDED),
                                          selectionTextStyle: const TextStyle(
                                            color: Colors.black,
                                          ),
                                          backgroundColor: Colors.white,
                                          headerHeight: 0,
                                          onViewChanged: viewChanged,
                                          monthCellStyle: DateRangePickerMonthCellStyle(
                                            weekendTextStyle: const TextStyle(color: Colors.red),
                                            todayCellDecoration: BoxDecoration(
                                                border: Border.all(
                                              width: 1.w,
                                              color: Colors.transparent,
                                            )),
                                            todayTextStyle: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xffEDEDED),
                                            ),
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Colors.black,
                                              backgroundColor: Colors.white,
                                            ),
                                          ),
                                          monthViewSettings: const DateRangePickerMonthViewSettings(
                                            firstDayOfWeek: DateTime.monday,
                                            viewHeaderStyle: DateRangePickerViewHeaderStyle(
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ]);
                      });
                    });
              },
              child: Image.asset(
                "assets/images/Icon metro-calendar@3x.png",
                scale: 2.5,
              ),
            )
          ],
        ),
        drawer: const DrawerScreen(),
        body: GetBuilder<EventController>(builder: (eventController) {
          return (eventController.isLoding
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: eventController.EventsData.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                                () => NewsAndEventsDetailsScreen(
                                      name: eventController.EventsData[index]['user']['name'],
                                      date: eventController.EventsData[index]['createdAt'].toString(),
                                      description: eventController.EventsData[index]['description'],
                                      timee: eventController.EventsData[index]['createdAt'].toString(),
                                      title: eventController.EventsData[index]['title'],
                                      location: eventController.EventsData[index]['location'].toString(),
                                      eventimage: eventController.EventsData[index]['file'][0]['file'],
                                      eventid: eventController.EventsData[index]['_id'],
                                    ),
                                duration: Duration(seconds: 1),
                                transition: Transition.fadeIn);
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 0.9.sw,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.r),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      20.verticalSpace,
                                      Row(
                                        children: [
                                          Container(
                                            width: 60.h,
                                            height: 60.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  "assets/images/Ellipse 68-1@3x.png",
                                                ),
                                                fit: BoxFit.fill,

                                                //     NetworkImage(
                                                //   "https://uaw-api.thesuitchstaging.com:3090/${eventController.EventsData[index]['file'][0]['file']}",
                                                // ),
                                              ),
                                            ),
                                          ),
                                          10.horizontalSpace,
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                eventController.EventsData[index]['user']['name'],
                                                style: txtstyleblue17,
                                              ),
                                              5.verticalSpace,
                                              Text(
                                                eventController.EventsData[index]['date'].toString(),
                                                style: textroboto12,
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Image.asset(
                                            "assets/images/Group 1333@3x.png",
                                            scale: 3.5,
                                          )
                                        ],
                                      ),
                                      15.verticalSpace,
                                      eventController.EventsData[index]['file'].length == 0
                                          ? Container(
                                              width: 1.sw,
                                              height: 0.5.sh,
                                              // height: 135.h,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.r),
                                                color: black,
                                                image: const DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                              ),
                                            )
                                          // StaggeredGrid.count(
                                          //     crossAxisCount: 3,
                                          //     mainAxisSpacing: 5,
                                          //     crossAxisSpacing: 5,
                                          //     children: [
                                          //       StaggeredGridTile.count(
                                          //         crossAxisCellCount: 1,
                                          //         mainAxisCellCount: 1,
                                          //         child: Container(
                                          //           width: 115.w,
                                          //           height: 135.h,
                                          //           decoration: BoxDecoration(
                                          //             borderRadius: BorderRadius.only(
                                          //               topLeft: Radius.circular(10.r),
                                          //             ),
                                          //             color: black,
                                          //             image:
                                          //                 const DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //       StaggeredGridTile.count(
                                          //         crossAxisCellCount: 1,
                                          //         mainAxisCellCount: 1,
                                          //         child: Container(
                                          //           width: 115.w,
                                          //           height: 135.h,
                                          //           decoration: const BoxDecoration(
                                          //             image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                          //             color: black,
                                          //           ),
                                          //         ),
                                          //       ),
                                          //       StaggeredGridTile.count(
                                          //         crossAxisCellCount: 1,
                                          //         mainAxisCellCount: 1,
                                          //         child: Container(
                                          //           width: 115.w,
                                          //           height: 135.h,
                                          //           decoration: BoxDecoration(
                                          //             color: black,
                                          //             borderRadius: BorderRadius.only(
                                          //               topRight: Radius.circular(10.r),
                                          //             ),
                                          //             image:
                                          //                 const DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //       StaggeredGridTile.count(
                                          //         crossAxisCellCount: 5,
                                          //         mainAxisCellCount: 1,
                                          //         child: Row(
                                          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //           children: [
                                          //             Container(
                                          //               width: 170.w,
                                          //               decoration: BoxDecoration(
                                          //                 borderRadius: BorderRadius.only(
                                          //                   bottomLeft: Radius.circular(10.r),
                                          //                 ),
                                          //                 color: black,
                                          //                 image: const DecorationImage(
                                          //                     image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                          //               ),
                                          //             ),
                                          //             Container(
                                          //               width: 170.w,
                                          //               decoration: BoxDecoration(
                                          //                 borderRadius: BorderRadius.only(
                                          //                   bottomRight: Radius.circular(10.r),
                                          //                 ),
                                          //                 color: black,
                                          //                 image: const DecorationImage(
                                          //                     image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                          //               ),
                                          //             ),
                                          //           ],
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   )

                                          : Image(
                                              image: NetworkImage(
                                                "https://uaw-api.thesuitchstaging.com:3090/${eventController.EventsData[index]['file'][0]['file']}",
                                              ),
                                            ),
                                      10.verticalSpace,
                                      Row(
                                        children: [
                                          Text(
                                            eventController.EventsData[index]['title'].toString(),
                                            style: textroboto15,
                                          ),
                                        ],
                                      ),
                                      20.verticalSpace,
                                    ],
                                  ),
                                ),
                              ),
                              15.verticalSpace,
                            ],
                          ),
                        ),
                      ],
                    );
                  }));
        }),
      ),
    );
  }
}

class Newsandeventswidget extends StatelessWidget {
  const Newsandeventswidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                20.verticalSpace,
                Row(
                  children: [
                    Container(
                      width: 60.h,
                      height: 60.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/Ellipse 68@3x.png",
                          ),
                        ),
                      ),
                    ),
                    10.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Admin",
                          style: txtstyleblue17,
                        ),
                        5.verticalSpace,
                        Text(
                          DateFormat(
                            "MM-dd-yyyy",
                          ).format(
                            DateTime.now(),
                          ),
                          style: textroboto12,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Image.asset(
                      "assets/images/Group 1333@3x.png",
                      scale: 3.5,
                    )
                  ],
                ),
                15.verticalSpace,
                StaggeredGrid.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: [
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: Container(
                        width: 115.w,
                        height: 135.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                          ),
                          color: black,
                          image: const DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: Container(
                        width: 115.w,
                        height: 135.h,
                        decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                          color: black,
                        ),
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: Container(
                        width: 115.w,
                        height: 135.h,
                        decoration: BoxDecoration(
                          color: black,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.r),
                          ),
                          image: const DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 5,
                      mainAxisCellCount: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 170.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.r),
                              ),
                              color: black,
                              image: const DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                            ),
                          ),
                          Container(
                            width: 170.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.r),
                              ),
                              color: black,
                              image: const DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae vulputate velit. Nulla facilisi. Fusce interdum ornare arcu, quis",
                  style: textroboto15,
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
        15.verticalSpace,
      ],
    );
  }
}
