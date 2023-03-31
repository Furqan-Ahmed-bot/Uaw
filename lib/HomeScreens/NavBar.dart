import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/NewsAndEvents.dart';
import 'package:_uaw/HomeScreens/Notification.dart';
import 'package:_uaw/HomeScreens/Profile.dart';
import 'package:_uaw/HomeScreens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../Controller.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  final bottomcontroller = Get.put(BottomController());
  int pageIndex = 0;

  final pages = [
    HomeScreen(),
    NewsAndEventsScreen(value: "null"),
    NotificationScreen(),
    UserProfileScreen(),
  ];
  void _onItemTapped(int index) {
    bottomcontroller.navBarChange(index);
  }

  @override
  Widget build(BuildContext context) {
    double res_height = MediaQuery.of(context).size.height;
    double res_width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Color.fromARGB(255, 236, 236, 236),
        body: GetBuilder<BottomController>(
          builder: (_) => pages[bottomcontroller.navigationBarIndexValue],
        ),
        // pages[pageIndex],
        bottomNavigationBar: GetBuilder<BottomController>(
          builder: (_) => buildMyNavBar(context),
        ),
      ),
    );
  }

  buildMyNavBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.r, right: 10.r, bottom: 10.r),
      child: Container(
        height: 70.h,
        width: double.infinity,
        decoration: BoxDecoration(boxShadow: [
          // BoxShadow(
          //   color: Colors.grey.withOpacity(0.5),
          //   spreadRadius: 2,
          //   blurRadius: 50,
          //   offset: Offset(0, -8), // changes position of shadow
          // ),
        ], borderRadius: BorderRadius.circular(20.r), color: Colors.black),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _onItemTapped(0);
                  });

                  // Get.to(() => MainScreen());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 22.5.w,
                      height: 22.5.h,
                      child: Image.asset(
                        "assets/images/Icon material-rss-feed@3x.png",
                        color: bottomcontroller.navigationBarIndexValue == 0 ? orangeshade : Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        letterSpacing: -0.48,
                        fontSize: 12.sp,
                        color: bottomcontroller.navigationBarIndexValue == 0 ? orangeshade : Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   width: 30.w,
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _onItemTapped(1);
                      });

                      // Get.to(() => MainScreen());
                    },
                    child: Container(
                      width: 22.5.w,
                      height: 22.5.h,
                      child: Image.asset(
                        "assets/images/Group 1300@3x.png",
                        color: bottomcontroller.navigationBarIndexValue == 1 ? orangeshade : Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Chat",
                    style: TextStyle(
                      letterSpacing: -0.48,
                      fontSize: 12.sp,
                      color: bottomcontroller.navigationBarIndexValue == 1 ? orangeshade : Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  setState(() {
                    _onItemTapped(2);
                  });

                  // Get.to(() => MainScreen());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 22.5.w,
                      height: 22.5.h,
                      child: Image.asset(
                        "assets/images/Group 1301@3x.png",
                        color: bottomcontroller.navigationBarIndexValue == 2 ? orangeshade : Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Bookings",
                      style: TextStyle(
                        letterSpacing: -0.48,
                        fontSize: 12.sp,
                        color: bottomcontroller.navigationBarIndexValue == 2 ? orangeshade : Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   width: 25.w,
              // ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _onItemTapped(3);
                  });

                  // Get.to(() => MainScreen());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 22.5.w,
                      height: 22.5.h,
                      child: Image.asset(
                        "assets/images/Group 1302@3x.png",
                        color: bottomcontroller.navigationBarIndexValue == 3 ? orangeshade : Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: bottomcontroller.navigationBarIndexValue == 3 ? orangeshade : Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
