import 'package:_uaw/Global.dart';
import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/Drawer.dart';
import 'package:_uaw/HomeScreens/NewsAndEvents.dart';
import 'package:_uaw/HomeScreens/Notification.dart';
import 'package:_uaw/HomeScreens/Profile.dart';
import 'package:_uaw/HomeScreens/SelectedDateEventDetails.dart';
import 'package:_uaw/HomeScreens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../Auth/Prelogin.dart';
import '../Controller.dart';
import 'Documents.dart';
import 'DrawerVideoPlayer.dart';
import 'Magzines.dart';
import 'Settings.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late PageController _pageController;

  late AnimationController _controller;
  late Animation<Offset> _animation;

  final List<Offset> _itemPositions = [
    Offset(0.0, 0.0),
    Offset(0.5, 0.0),
    Offset(1.0, 0.0),
    Offset(1.5, 0.0),
  ];
  // how to o
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: _itemPositions[pageIndex],
      end: _itemPositions[pageIndex],
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  final Color _semiCircleColor = Colors.blue;
  final bottomcontroller = Get.put(BottomController());
  int pageIndex = 0;

  final pages = [
    HomeScreen(cameFrom: 'login'),
    selection == true ? SelectedDateEventDetailsScreen() : NewsAndEventsScreen(value: "null"),
    NotificationScreen(),
    UserProfileScreen(),
  ];
  void _onItemTapped(int pageIndex) {
    print("index" + pageIndex.toString());
    setState(() {
      pageIndex = pageIndex;

      _animation = Tween<Offset>(
        begin: _itemPositions[pageIndex],
        end: _itemPositions[pageIndex],
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceIn));
      _controller.forward(from: 0);
    });
    bottomcontroller.navBarChange(pageIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double res_height = MediaQuery.of(context).size.height;
    double res_width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      child: Scaffold(
        extendBody: true,
        drawer: DrawerScreen(),

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
      padding: EdgeInsets.only(left: 20.r, right: 20.r, bottom: 10.r),
      child: Container(
        height: 65.h,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xff021B36), Color(0xff175698)],
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  setState(() {
                    _onItemTapped(0);
                  });

                  // Get.to(() => MainScreen());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 22.5.w,
                      height: 22.5.h,
                      child: Image.asset(
                        "assets/images/Icon material-rss-feed@3x.png",
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Feed",
                      style: TextStyle(
                        letterSpacing: -0.48,
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    5.verticalSpace,
                    Container(
                      height: 8.h,
                      width: 15.w,
                      decoration: BoxDecoration(
                          color: bottomcontroller.navigationBarIndexValue == 0 ? Color(0xff38A8FE) : transparentcolor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(100.r), topRight: Radius.circular(100.r))),
                    )
                  ],
                ),
              ),
              // SizedBox(
              //   width: 30.w,
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
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
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Events",
                    style: TextStyle(
                      letterSpacing: -0.48,
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  5.verticalSpace,
                  Container(
                    height: 8.h,
                    width: 15.w,
                    decoration: BoxDecoration(
                        color: bottomcontroller.navigationBarIndexValue == 1 ? Color(0xff38A8FE) : transparentcolor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(100.r), topRight: Radius.circular(100.r))),
                  )
                ],
              ),

              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  setState(() {
                    _onItemTapped(2);
                  });

                  // Get.to(() => MainScreen());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 22.5.w,
                      height: 22.5.h,
                      child: Image.asset(
                        "assets/images/Group 1301@3x.png",
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Notifications",
                      style: TextStyle(
                        letterSpacing: -0.48,
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    5.verticalSpace,
                    Container(
                      height: 8.h,
                      width: 15.w,
                      decoration: BoxDecoration(
                          color: bottomcontroller.navigationBarIndexValue == 2 ? Color(0xff38A8FE) : transparentcolor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(100.r), topRight: Radius.circular(100.r))),
                    )
                  ],
                ),
              ),
              // SizedBox(
              //   width: 25.w,
              // ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  setState(() {
                    _onItemTapped(3);
                  });

                  // Get.to(() => MainScreen());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 22.5.w,
                      height: 22.5.h,
                      child: Image.asset(
                        "assets/images/Group 1302@3x.png",
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    5.verticalSpace,
                    Container(
                      height: 8.h,
                      width: 15.w,
                      decoration: BoxDecoration(
                          color: bottomcontroller.navigationBarIndexValue == 3 ? Color(0xff38A8FE) : transparentcolor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(100.r), topRight: Radius.circular(100.r))),
                    )
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
