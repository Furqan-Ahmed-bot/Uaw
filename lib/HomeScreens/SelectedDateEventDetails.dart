import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/SelectedDateEvents.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SelectedDateEventDetailsScreen extends StatefulWidget {
  const SelectedDateEventDetailsScreen({super.key});

  @override
  State<SelectedDateEventDetailsScreen> createState() => _SelectedDateEventDetailsScreenState();
}

class _SelectedDateEventDetailsScreenState extends State<SelectedDateEventDetailsScreen> {
  String tdata = DateFormat("HH:mm a").format(DateTime.now());
  DateTime currentTime = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    return 
    Container(
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
                "14 SEPTEMBER 2023",
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
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/Icon feather-clock@3x.png",
                        scale: 3.5,
                      ),
                      5.horizontalSpace,
                      Text(
                        tdata,
                        style: textroboto14blue,
                      )
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
                  image: DecorationImage(
                    image: AssetImage("assets/images/Group 1440@3x.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              15.verticalSpace,
              Text(
                "Lorem ipsum dolor sit amet, consectetur",
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
                    tdata,
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
              Row(
                children: [
                  Image.asset(
                    "assets/images/Icon feather-map-pin@3x.png",
                    scale: 3.5,
                  ),
                  15.horizontalSpace,
                  Text(
                    "Lorem Ipsum Dolor Sitamet,",
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
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae vulputate velit. Nulla facilisi. Fusce interdum ornare arcu, quis",
                style: textroboto15black,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        barrierDismissible: true,
                        // barrierColor: Colors.white,
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (BuildContext context, setState) {
                              return AlertDialog(
                                insetPadding: EdgeInsets.zero,
                                backgroundColor: Color(0xff000000B8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0.r),
                                ),
                                contentPadding: EdgeInsets.all(0),
                                actionsPadding: EdgeInsets.all(0),
                                actions: [
                                  Container(
                                    width: 370.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Color(0xffFFFFFF)),
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
                                        30.verticalSpace,
                                        Text(
                                          "Are you sure you want to reject?",
                                          textAlign: TextAlign.center,
                                          style: txtstyleblue25,
                                        ),
                                        30.verticalSpace,
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
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
                                                Get.to(() => SelectedDateEventsScreen(),
                                                    duration: Duration(seconds: 1), transition: Transition.fadeIn);
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
                  GestureDetector(
                    onTap: () {
                      Get.back();
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
