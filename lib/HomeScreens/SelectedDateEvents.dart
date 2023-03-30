import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/SelectedDateEventDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart' as intl;

class SelectedDateEventsScreen extends StatefulWidget {
  const SelectedDateEventsScreen({super.key});

  @override
  State<SelectedDateEventsScreen> createState() => _SelectedDateEventsScreenState();
}

class _SelectedDateEventsScreenState extends State<SelectedDateEventsScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  final kToday = DateTime.now();
  final kFirstDay = DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);
  final kLastDay = DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);
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

  void viewChanged(DateRangePickerViewChangedArgs args) {
    final DateTime visibleStartDate = args.visibleDateRange.startDate!;
    final DateTime visibleEndDate = args.visibleDateRange.endDate!;
    final int totalVisibleDays = (visibleStartDate.difference(visibleEndDate).inDays);
    final DateTime midDate = visibleStartDate.add(Duration(days: totalVisibleDays ~/ 2));
    headerString = intl.DateFormat('MMMM yyyy').format(midDate).toString();
    SchedulerBinding.instance!.addPostFrameCallback((duration) {
      setState(() {});
    });
  }

  bool timezone = false;
  final DateRangePickerController _controller = DateRangePickerController();
  String headerString = '';

  String now = DateFormat("yyyy-MM-dd").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      color: whitish,
      child: Scaffold(
        backgroundColor: transparentcolor,
        appBar: AppBar(
          backgroundColor: transparentcolor,
          elevation: 0,
          leadingWidth: 70,
          leading: Center(
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                "assets/images/Group 1430@3x.png",
                scale: 2.5,
              ),
            ),
          ),
          title: Text(
            "14 SEPTEMBER 2023",
            style: textroboto18,
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (BuildContext context, setState) {
                        return AlertDialog(
                            insetPadding: EdgeInsets.zero,
                            scrollable: true,
                            backgroundColor: Color(0xff000000B8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0.r),
                            ),
                            contentPadding: EdgeInsets.all(0),
                            actionsPadding: EdgeInsets.all(0),
                            actions: [
                              Container(
                                width: 0.8.sw,
                                height: 0.5.sh,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: Color(0xffFFFFFF)),
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
                                            child: Icon(
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
                                      padding: EdgeInsets.symmetric(horizontal: 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: IconButton(
                                              icon: Icon(Icons.arrow_back_ios),
                                              color: Colors.black,
                                              iconSize: 20,
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    _controller.backward!();
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Container(
                                            child: Text(headerString,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          Container(
                                              child: IconButton(
                                            icon: Icon(
                                              Icons.arrow_forward_ios,
                                            ),
                                            color: Colors.black,
                                            iconSize: 20,
                                            onPressed: () {
                                              setState(() {
                                                _controller.forward!();
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
                                          allowViewNavigation: true,
                                          // onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                                          //   Get.to(() => SelectedDateEventsScreen());
                                          // },
                                          selectionColor: Color(0xffEDEDED),
                                          selectionTextStyle: TextStyle(
                                            color: Colors.black,
                                          ),
                                          backgroundColor: Colors.white,
                                          controller: _controller,
                                          view: DateRangePickerView.month,
                                          headerHeight: 0,
                                          onViewChanged: viewChanged,
                                          monthCellStyle: DateRangePickerMonthCellStyle(
                                            weekendTextStyle: TextStyle(color: Colors.red),
                                            todayCellDecoration: BoxDecoration(
                                                border: Border.all(
                                              width: 1.w,
                                              color: Colors.transparent,
                                            )),
                                            todayTextStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xffEDEDED),
                                            ),
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Colors.black,
                                              backgroundColor: Colors.white,
                                            ),
                                          ),
                                          monthViewSettings: DateRangePickerMonthViewSettings(
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                15.verticalSpace,
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext contex, i) {
                      return GestureDetector(
                          onTap: () {
                            Get.to(() => SelectedDateEventDetailsScreen(), duration: Duration(seconds: 1), transition: Transition.fadeIn);
                          },
                          child: SelectedDateWidget());
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectedDateWidget extends StatelessWidget {
  const SelectedDateWidget({
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
                      decoration: BoxDecoration(
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
                    Spacer(),
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
                          image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
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
                          image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
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
                              image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                            ),
                          ),
                          Container(
                            width: 170.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.r),
                              ),
                              color: black,
                              image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
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
