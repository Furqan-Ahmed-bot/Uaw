import 'package:_uaw/Controllers/usercontroller.dart';
import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/AttendingEvent.dart';
import 'package:_uaw/HomeScreens/Drawer.dart';
import 'package:_uaw/HomeScreens/EditProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:_uaw/Global.dart';

import '../Controllers/eventcontroller.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;

    final firstLetter = text.substring(0, 1).toUpperCase();
    final remainingLetters = text.substring(1);
    return '$firstLetter$remainingLetters';
  }

  TextEditingController Locationcontroller = TextEditingController();
  final UserDetails = Get.put(UserController());
  final eventcontroller = Get.put(EventController());
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    completeAddress;
    String designationTitle = UserController.user.data!.designation!.title.toString();
    String capitalizedTitle = capitalizeFirstLetter(designationTitle);

    return Scaffold(
        key: _key,
        backgroundColor: whitish,
        drawer: DrawerScreen(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 1.sw,
                height: 180.h,
                decoration: BoxDecoration(
                  gradient: SweepGradient(
                    colors: [
                      whitecolor,
                      bluishshade,
                    ],
                    center: Alignment.bottomLeft,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.r,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => DrawerScreen(), transition: Transition.leftToRight, duration: Duration(milliseconds: 300));
                            },
                            child: Center(
                              child: Container(
                                width: 55.w,
                                height: 55.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: whitecolor,
                                ),
                                child: Image.asset(
                                  "assets/images/Group 1288@3x.png",
                                  scale: 2.5,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => EditProfileScreen());
                            },
                            child: Image.asset(
                              "assets/images/Group 1377@3x.png",
                              scale: 3.5,
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        child: Text(
                          "PROFILE",
                          style: txtstylewhite18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 1.sw,
                  ),
                  Positioned(
                    top: -40,
                    child: Container(
                      width: 140.w,
                      height: 140.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 5.w,
                          color: Color(0xff00000026),
                        ),
                        image: DecorationImage(
                            image: NetworkImage('https://uaw-api.thesuitchstaging.com:3090/${UserController.user.data!.image!.file}'),
                            fit: BoxFit.cover),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Container(
                          //   width: 40.w,
                          //   height: 40.h,
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     color: bluishshade,
                          //   ),
                          //   child: Icon(
                          //     Icons.camera_alt,
                          //     color: whitecolor,
                          //     size: 20,
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              100.verticalSpace,
              Text(
                UserController.user.data!.name.toString(),
                style: textroboto20,
              ),
              5.verticalSpace,
              Text(
                UserController.user.data!.email.toString(),
                style: txtstyleblack14WO,
              ),
              40.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Designation",
                      style: txtstyleblack14WO,
                    ),
                    5.verticalSpace,
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        prefixIconConstraints: BoxConstraints(minWidth: 50),
                        prefixIcon: Image.asset(
                          "assets/images/Icon feather-user@3x3.png",
                          scale: 3.5,
                        ),
                        hintText: capitalizedTitle,
                        hintStyle: txtstyleblack14WO,
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
                    15.verticalSpace,
                    Text(
                      "Phone Number",
                      style: txtstyleblack14WO,
                    ),
                    5.verticalSpace,
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        prefixIconConstraints: BoxConstraints(minWidth: 50),
                        prefixIcon: Image.asset(
                          "assets/images/Icon feather-phone-call@3x.png",
                          scale: 3.5,
                        ),
                        hintText: UserController.user.data!.phone.toString(),
                        hintStyle: medium18blackwopacity,
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
                    15.verticalSpace,
                    Text(
                      "Location",
                      style: txtstyleblack14WO,
                    ),
                    5.verticalSpace,
                    TextFormField(
                      minLines: 1,
                      maxLines: null,
                      enabled: false,
                      decoration: InputDecoration(
                        hintMaxLines: 2,
                        filled: true,
                        fillColor: white,
                        prefixIconConstraints: BoxConstraints(minWidth: 50),
                        prefixIcon: Image.asset(
                          "assets/images/Group 1313@3x.png",
                          scale: 3.5,
                        ),
                        hintText: UserController.user.data!.location.toString(),
                        hintStyle: medium18blackwopacity,
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
                    15.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Attending Events",
                          style: txtstyleblack14WO,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => AttendingEventScreen(), duration: Duration(seconds: 1), transition: Transition.fadeIn);
                          },
                          child: Text(
                            "View All",
                            style: txtstylebluehshade14,
                          ),
                        ),
                      ],
                    ),
                    5.verticalSpace,
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        prefixIconConstraints: BoxConstraints(minWidth: 50),
                        prefixIcon: Icon(
                          Icons.calendar_month_outlined,
                          color: black,
                        ),

                        //  Image.asset(
                        //   "assets/images/Group 60@3x.png",
                        //   scale: 3.5,
                        //   color: black,
                        // ),
                        hintText: "${eventcontroller.MyEvents.length.toString()} Attending Events",
                        hintStyle: medium18blackwopacity,
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
                    30.verticalSpace,
                  ],
                ),
              ),
              80.verticalSpace,
            ],
          ),
        ));
  }
}
