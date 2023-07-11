import 'dart:convert';

import 'package:_uaw/Auth/APIService/API.dart';
import 'package:_uaw/Auth/Adminlogin.dart';
import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/AboutApp.dart';
import 'package:_uaw/HomeScreens/HelpAndSupport.dart';
import 'package:_uaw/HomeScreens/NewsAndEventDetails.dart';
import 'package:_uaw/HomeScreens/PrivicyAndPolicy.dart';
import 'package:_uaw/HomeScreens/SelectedDateEvents.dart';
import 'package:_uaw/HomeScreens/TermsAndCondiciton.dart';
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
import 'package:http/http.dart' as http;

import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart' as intl;

import '../Auth/Prelogin.dart';
import '../Global.dart';

bool toggle = false;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //switch value

  void initState() {
    super.initState();
  }

  Future<void> Notification(bool enabled) async {
    final Url = Uri.parse("${apiGlobal}/user/update");
    var body = {"notificationOn": enabled};
    var jsonbody = json.encode(body);
    http.Response response = await http.post(
      Url,
      headers: {
        "Authorization": "Bearer $AuthToken",
        'Content-Type': 'application/json',
      },
      body: jsonbody,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {});
      Get.snackbar('succesfully', "Notification Update succesfully",
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 3), backgroundColor: Colors.white, colorText: Colors.black);
    } else {
      setState(() {
        toggle = !toggle;
      });
      Get.snackbar('Error', "Notification Not Update",
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 3), backgroundColor: Colors.white, colorText: Colors.black);
    }
  }

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
            "SETTINGS",
            style: textroboto18,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Container(
            width: 1.sw,
            height: 1.sh,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    15.verticalSpace,
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: 1.sw,
                        decoration: BoxDecoration(
                          color: whitecolor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Notification",
                              style: robotobluishshade16bold,
                            ),
                            Transform.scale(
                              alignment: Alignment.centerRight,
                              scale: 0.8,
                              child: CupertinoSwitch(
                                activeColor: bluishshade,
                                value: toggle,
                                onChanged: (value) {
                                  toggle = !toggle;
                                  Notification(toggle);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    15.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        Get.to(() => HelpAndSupport());
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: 1.sw,
                        decoration: BoxDecoration(
                          color: whitecolor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Help Support",
                              style: robotobluishshade16bold,
                            ),
                            Image.asset(
                              "assets/images/Group 1444.png",
                              // scale: 3.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    15.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => PrivicyAndPolicyScreen(
                            value: "",
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: 1.sw,
                        decoration: BoxDecoration(
                          color: whitecolor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Hero(
                              tag: "policy",
                              child: Material(
                                type: MaterialType.transparency,
                                child: Text(
                                  "Privacy Policy",
                                  style: robotobluishshade16bold,
                                ),
                              ),
                            ),
                            Image.asset(
                              "assets/images/Group 1445.png",
                              // scale: 3.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    15.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        Get.to(() => TermAndCondicitonScreen(value: ""));
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: 1.sw,
                        decoration: BoxDecoration(
                          color: whitecolor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Hero(
                              tag: "term",
                              child: Material(
                                type: MaterialType.transparency,
                                child: Text(
                                  "Terms & Conditions",
                                  style: robotobluishshade16bold,
                                ),
                              ),
                            ),
                            Image.asset(
                              "assets/images/Group 1446.png",
                              // scale: 3.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    15.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        Get.to(() => AboutAppScreen(value: ""));
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: 1.sw,
                        decoration: BoxDecoration(
                          color: whitecolor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Hero(
                              tag: "aboutApp",
                              child: Material(
                                type: MaterialType.transparency,
                                child: Text(
                                  "About App",
                                  style: robotobluishshade16bold,
                                ),
                              ),
                            ),
                            Image.asset(
                              "assets/images/Group 1447.png",
                              // scale: 3.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
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
                                        "Are you sure you want to Logout ?",
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
                                              ApiService().logoutAPI(context);
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
                    padding: EdgeInsets.all(15),
                    width: 1.sw,
                    // height: 55.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: bluishshade,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Logout",
                          style: txtstylewhite18bold,
                        ),
                        Image.asset(
                          "assets/images/Group 992.png",
                          scale: 1.5,
                        ),
                      ],
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
