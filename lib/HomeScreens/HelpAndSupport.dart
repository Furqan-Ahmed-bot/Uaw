import 'package:_uaw/Auth/Adminlogin.dart';
import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/NewsAndEventDetails.dart';
import 'package:_uaw/HomeScreens/SelectedDateEvents.dart';
import 'package:_uaw/HomeScreens/home.dart';
import 'package:flutter/cupertino.dart';
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

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({
    super.key,
  });

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  //switch value
  bool switchValue = true;

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
            "HELP & SUPPORT",
            style: textroboto18,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                50.verticalSpace,
                Column(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/help-desk.png",
                        scale: 1.2,
                      ),
                    ),
                    40.verticalSpace,
                    Text(
                      textAlign: TextAlign.center,
                      "We are here to help so, please get in touch with us.",
                      style: txtstyleblack22,
                    ),
                  ],
                ),
                50.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Full Name",
                      style: txtstyleblack14regular,
                    ),
                    10.verticalSpace,
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        prefixIconConstraints: BoxConstraints(minWidth: 50),
                        prefixIcon: Image.asset(
                          "assets/images/Icon feather-user@3x3.png",
                          scale: 3.5,
                        ),
                        hintText: "Enter your name",
                        hintStyle: txtstyleblack14regular,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: transparentcolor,
                            width: 1.w,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: transparentcolor,
                            width: 1.w,
                          ),
                        ),
                      ),
                      style: medium18blackwopacity,
                    ),
                  ],
                ),
                20.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: txtstyleblack14regular,
                    ),
                    10.verticalSpace,
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        prefixIconConstraints: BoxConstraints(minWidth: 50),
                        prefixIcon: Image.asset(
                          "assets/images/Icon ionic-ios-email@3x.png",
                          color: blackcolor,
                          scale: 3.5,
                        ),
                        hintText: "email@domain.com",
                        hintStyle: txtstyleblack14regular,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: transparentcolor,
                            width: 1.w,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: transparentcolor,
                            width: 1.w,
                          ),
                        ),
                      ),
                      style: medium18blackwopacity,
                    ),
                  ],
                ),
                20.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Phone Number",
                      style: txtstyleblack14regular,
                    ),
                    10.verticalSpace,
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        prefixIconConstraints: BoxConstraints(minWidth: 50),
                        prefixIcon: Image.asset(
                          "assets/images/Icon feather-phone-call@3x.png",
                          color: blackcolor,
                          scale: 3.5,
                        ),
                        hintText: "123 456 7890",
                        hintStyle: txtstyleblack14regular,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: transparentcolor,
                            width: 1.w,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: transparentcolor,
                            width: 1.w,
                          ),
                        ),
                      ),
                      style: medium18blackwopacity,
                    ),
                  ],
                ),
                20.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Message",
                      style: txtstyleblack14regular,
                    ),
                    10.verticalSpace,
                    TextFormField(
                      maxLines: 2,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        hintText: "Type your message here...",
                        hintStyle: txtstyleblack14regular,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: transparentcolor,
                            width: 1.w,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: transparentcolor,
                            width: 1.w,
                          ),
                        ),
                      ),
                      style: medium18blackwopacity,
                    ),
                  ],
                ),
                40.verticalSpace,
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
                                      20.verticalSpace,
                                      Center(
                                        child: Image.asset(
                                          "assets/images/check@3x.png",
                                          scale: 3.5,
                                        ),
                                      ),
                                      Text(
                                        "Success",
                                        textAlign: TextAlign.center,
                                        style: txtstyleblack26bold,
                                      ),
                                      20.verticalSpace,
                                      Container(
                                        width: 0.6.sw,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "Lorem ipsum dolor sit amet, consectetur",
                                          style: textrobotobluishshade22Medium,
                                        ),
                                      ),
                                      40.verticalSpace,
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
                    width: 1.sw,
                    height: 55.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: bluishshade,
                    ),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: txtstylewhite20,
                      ),
                    ),
                  ),
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
