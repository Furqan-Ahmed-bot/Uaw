import 'package:_uaw/Auth/Prelogin.dart';
import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/Documents.dart';
import 'package:_uaw/HomeScreens/Magzines.dart';
import 'package:_uaw/HomeScreens/NewsAndEvents.dart';
import 'package:_uaw/HomeScreens/Profile.dart';
import 'package:_uaw/HomeScreens/VideosScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.r),
            // bottomRight: Radius.circular(20.r),
          ),
          child: Container(
            width: 0.8.sw,
            height: 0.9.sh,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: 0.8.sw,
                  height: 0.9.sh,
                  child: Image.asset(
                    "assets/images/Rectangle 74@3x.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: 0.8.sw,
                  height: 0.9.sh,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff04366BCC).withOpacity(0.0),
                        Color(0xff000000E6).withOpacity(0.5),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      30.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.r),
                            child: Icon(
                              Icons.close,
                              color: whitecolor,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      40.verticalSpace,
                      Container(
                        width: 130.w,
                        height: 130.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 5.w,
                            color: whitecolor,
                          ),
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/Group 1433@3x1.png"),
                              fit: BoxFit.fill),
                        ),
                      ),
                      20.verticalSpace,
                      Text(
                        "John Doe",
                        style: medium20white,
                      ),
                      Text(
                        "johndoe@gmail.com",
                        style: fontsize16opacitywhite,
                      ),
                      50.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.r),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 400.h,
                              child: ListView(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/Icon material-rss-feed@3x.png",
                                          scale: 2,
                                        ),
                                        20.horizontalSpace,
                                        Text(
                                          "Feed",
                                          style: medium18white,
                                        )
                                      ],
                                    ),
                                  ),
                                  30.verticalSpace,
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() =>
                                          NewsAndEventsScreen(value: "null"));
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/Group 60@3x.png",
                                          scale: 2,
                                        ),
                                        20.horizontalSpace,
                                        Text(
                                          "Events",
                                          style: medium18white,
                                        )
                                      ],
                                    ),
                                  ),
                                  30.verticalSpace,
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => UserProfileScreen());
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/Icon feather-user@3x.png",
                                          scale: 2,
                                        ),
                                        20.horizontalSpace,
                                        Text(
                                          "Profile",
                                          style: medium18white,
                                        )
                                      ],
                                    ),
                                  ),
                                  30.verticalSpace,
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          () => DocumentsScreen(value: "null"));
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/Group 169@3x.png",
                                          scale: 2,
                                        ),
                                        20.horizontalSpace,
                                        Text(
                                          "Documents",
                                          style: medium18white,
                                        )
                                      ],
                                    ),
                                  ),
                                  30.verticalSpace,
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => VideoScreen(value: "null"));
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/Icon material-slow-motion-video@3x.png",
                                          scale: 2,
                                        ),
                                        20.horizontalSpace,
                                        Text(
                                          "Videos",
                                          style: medium18white,
                                        )
                                      ],
                                    ),
                                  ),
                                  30.verticalSpace,
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          () => MagzineScreen(value: "null"));
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/Group 170@3x.png",
                                          scale: 2,
                                        ),
                                        20.horizontalSpace,
                                        Text(
                                          "Magazines",
                                          style: medium18white,
                                        )
                                      ],
                                    ),
                                  ),
                                  30.verticalSpace,
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/Icon feather-settings@3x.png",
                                        scale: 2,
                                      ),
                                      20.horizontalSpace,
                                      Text(
                                        "Settings",
                                        style: medium18white,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
            width: 0.8.sw,
            height: 80.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20.r),
              ),
              color: whitecolor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.r),
              child: GestureDetector(
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
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: Color(0xffFFFFFF)),
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
                                                bottomLeft:
                                                    Radius.circular(15.r),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            width: 162.w,
                                            height: 55.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
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
                                            Get.to(() => PreloginScreen(),
                                                duration: Duration(seconds: 1),
                                                transition: Transition.fadeIn);
                                          },
                                          child: Container(
                                            width: 162.w,
                                            height: 55.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
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
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/Group 965@3x.png",
                      scale: 3.5,
                    ),
                    20.horizontalSpace,
                    Text(
                      "Logout",
                      style: medium18black,
                    )
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
