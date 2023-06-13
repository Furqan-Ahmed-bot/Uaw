// ignore_for_file: prefer_const_constructors

import 'package:_uaw/Auth/APIService/API.dart';
import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/NavBar.dart';
import 'package:_uaw/HomeScreens/NewsAndEvents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dotted_line/dotted_line.dart';

import '../Controller.dart';

class NewsAndEventsDetailsScreen extends StatefulWidget {
  final eventid;
  final name;
  final timee;
  final date;
  final title;
  final description;
  final location;
  final eventimage;
  const NewsAndEventsDetailsScreen({
    required this.eventid,
    required this.name,
    required this.timee,
    required this.date,
    required this.title,
    required this.description,
    required this.location,
    this.eventimage,
    super.key,
  });

  @override
  State<NewsAndEventsDetailsScreen> createState() => _NewsAndEventsDetailsScreenState();
}

class _NewsAndEventsDetailsScreenState extends State<NewsAndEventsDetailsScreen> with SingleTickerProviderStateMixin {
  final bottomcontroller = Get.put(BottomController());
  final bool _isTextOnLeft = true;
  final double _textSize = 24.0;
  final String _text1 = 'Flutter';
  final String _text2 = 'Dart';
  late AnimationController controller;
  bool swapped = false;
  late AnimationController _controller;
  late List<Animation<Offset>> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _offsetAnimation = List.generate(
      2,
      (index) => Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: Offset(index == 0 ? 1.11 : -1.11, 0),
      ).animate(_controller),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _animate() {
    _controller.status == AnimationStatus.completed ? _controller.reverse() : _controller.forward();
  }

  String tdata = DateFormat("HH:mm a").format(DateTime.now());
  DateTime currentTime = DateTime.now();
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
          title: Hero(
            tag: "newtag",
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                "NEWS & EVENTS",
                style: textroboto18,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Column(
            children: [
              35.verticalSpace,
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
                        widget.name,
                        style: txtstyleblue17,
                      ),
                      5.verticalSpace,
                      Text(
                        widget.date,
                        style: textroboto12,
                      ),
                      // Text(
                      //   DateFormat(
                      //     "MMM dd yyyy",
                      //   ).format(
                      //     DateTime.now(),
                      //   ),
                      //   style: textroboto12,

                      // ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/Icon feather-clock@3x.png",
                        scale: 3.5,
                      ),
                      5.horizontalSpace,
                      Text(
                        "03:00 Pm",
                        style: textroboto14blue,
                      ),
                      // Text(
                      //   tdata,
                      //   style: textroboto14blue,
                      // )
                    ],
                  ),
                ],
              ),
              15.verticalSpace,
              Container(
                width: 1.sw,
                height: 328.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: widget.eventimage == null
                      ? DecorationImage(
                          image: AssetImage("assets/images/Group 1440@3x.png"),
                          fit: BoxFit.fill,
                        )
                      : DecorationImage(
                          image: NetworkImage('https://uaw-api.thesuitchstaging.com:3090/${widget.eventimage}'),
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              15.verticalSpace,
              Text(
                widget.title,
                style: txtstyleblue24,
              ),
              15.verticalSpace,
              DottedLine(
                direction: Axis.horizontal,
                lineLength: 0.9.sw,
                lineThickness: 1.0,
                dashLength: 4.0,
                dashColor: bluishshade,
                dashRadius: 0.0,
                dashGapLength: 4.0,
                dashGapColor: Colors.transparent,
                dashGapRadius: 0.0,
              ),
              15.verticalSpace,
              Row(
                children: [
                  Image.asset(
                    "assets/images/Icon feather-clock@3x.png",
                    scale: 3.5,
                  ),
                  15.horizontalSpace,
                  Text(
                    widget.timee,
                    style: textroboto14blue,
                  ),
                  // Text(
                  //   tdata,
                  //   style: textroboto14blue,
                  // )
                ],
              ),
              15.verticalSpace,
              DottedLine(
                direction: Axis.horizontal,
                lineLength: 0.9.sw,
                lineThickness: 1.0,
                dashLength: 4.0,
                dashColor: bluishshade,
                dashRadius: 0.0,
                dashGapLength: 4.0,
                dashGapColor: Colors.transparent,
                dashGapRadius: 0.0,
              ),
              15.verticalSpace,
              Row(
                children: [
                  Image.asset(
                    "assets/images/Icon feather-map-pin@3x.png",
                    scale: 3.5,
                  ),
                  15.horizontalSpace,
                  Text(
                    widget.location,
                    style: textroboto14blue,
                  )
                ],
              ),
              15.verticalSpace,
              DottedLine(
                direction: Axis.horizontal,
                lineLength: 0.9.sw,
                lineThickness: 1.0,
                dashLength: 4.0,
                dashColor: bluishshade,
                dashRadius: 0.0,
                dashGapLength: 4.0,
                dashGapColor: Colors.transparent,
                dashGapRadius: 0.0,
              ),
              15.verticalSpace,
              Text(
                widget.description ?? '',
                style: textroboto15black,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SlideTransition(
                    position: _offsetAnimation[0],
                    child: GestureDetector(
                      onTap: () {
                        _animate();
                        showDialog(
                          barrierDismissible: true,
                          // barrierColor: Colors.white,
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (BuildContext context, setState) {
                                return AlertDialog(
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor: Color(0xff000000b8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0.r),
                                  ),
                                  contentPadding: EdgeInsets.all(0),
                                  actionsPadding: EdgeInsets.all(0),
                                  actions: [
                                    Container(
                                      width: 370.w,
                                      height: 210.h,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Color(0xffFFFFFF)),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      _animate();
                                                    },
                                                  );
                                                  Get.back();
                                                },
                                                child: Container(
                                                  width: 35.w,
                                                  height: 35.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                      bottomLeft: Radius.circular(15.r),
                                                      topRight: Radius.circular(15.r),
                                                    ),
                                                    color: bluishshade,
                                                  ),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: white,
                                                    size: 25.r,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          5.verticalSpace,
                                          SizedBox(
                                            width: 0.7.sw,
                                            child: Text(
                                              "Are you sure you want to reject?",
                                              textAlign: TextAlign.center,
                                              style: txtstyleblue25,
                                            ),
                                          ),
                                          20.verticalSpace,
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      _animate();
                                                    },
                                                  );
                                                  Get.back();
                                                },
                                                child: Container(
                                                  width: 162.w,
                                                  height: 55.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.r),
                                                    color: redishcolor,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "No",
                                                      style: medium16white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  bottomcontroller.navBarChange(1);
                                                  Get.to(() => NavBarScreen(), duration: Duration(seconds: 1), transition: Transition.fadeIn);
                                                },
                                                child: Container(
                                                  width: 162.w,
                                                  height: 55.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.r),
                                                    color: bluishshade,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Yes",
                                                      style: medium16white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          20.verticalSpace,
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 189.w,
                        height: 55.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: redishcolor,
                        ),
                        child: Center(
                          child: Text(
                            "Reject",
                            style: txtstylewhite20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: _offsetAnimation[1],
                    child: GestureDetector(
                      onTap: () {
                        ApiService().joinEvent(widget.eventid, context);
                      },
                      child: Container(
                        width: 189.w,
                        height: 55.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: bluishshade,
                        ),
                        child: Center(
                          child: Text(
                            "Accept",
                            style: txtstylewhite20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
