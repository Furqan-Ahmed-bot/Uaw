import 'package:_uaw/Helpers.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendingEventDetailsScreen extends StatefulWidget {
  const AttendingEventDetailsScreen({super.key});

  @override
  State<AttendingEventDetailsScreen> createState() => _AttendingEventDetailsScreenState();
}

class _AttendingEventDetailsScreenState extends State<AttendingEventDetailsScreen> {
  String tdata = DateFormat("HH:mm a").format(DateTime.now());
  DateTime currentTime = new DateTime.now();
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
          title: Material(
            type: MaterialType.transparency,
            child: Text(
              "ATTENDING EVENTS",
              style: textroboto18,
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
                          "MMM dd yyyy",
                        ).format(
                          DateTime.now(),
                        ),
                        style: textroboto12,
                      ),
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
                    "03:00 Pm",
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
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
