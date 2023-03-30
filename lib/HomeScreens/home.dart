import 'dart:developer';

import 'package:_uaw/Auth/CreateProfile.dart';

import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/Documents.dart';
import 'package:_uaw/HomeScreens/Drawer.dart';
import 'package:_uaw/HomeScreens/Magzines.dart';
import 'package:_uaw/HomeScreens/NewsAndEventDetails.dart';
import 'package:_uaw/HomeScreens/NewsAndEvents.dart';
import 'package:_uaw/HomeScreens/Settings.dart';
import 'package:_uaw/HomeScreens/VideoScreen.dart';
import 'package:_uaw/HomeScreens/VideosScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String now = DateFormat("yyyy-MM-dd").format(DateTime.now());
  int i = 0;

  // List routingscreennames = [
  //   DocumentsScreen(),
  //   CreateProfileScreen(),
  //   DocumentsScreen(),
  //   CreateProfileScreen(),
  //   DocumentsScreen(),
  //   CreateProfileScreen(),
  // ];
  List StatusWidgetDetails = [
    {
      "containerimage":
          "assets/images/romain-dancre-doplSDELX7E-unsplash@3x.png",
      "statustext": "Documents",
      "navigateTo": "DocumentsScreen"
    },
    {
      "containerimage":
          "assets/images/zhang-shaoqi-PdUACzBJP-Y-unsplash@3x.png",
      "statustext": "Videos",
      "navigateTo": "DocumentsScreen"
    },
    {
      "containerimage":
          "assets/images/krakenimages-Y5bvRlcCx8k-unsplash@3x.png",
      "statustext": "Magzine",
      "navigateTo": "DocumentsScreen"
    },
    {
      "containerimage": "assets/images/md-duran-rE9vgD_TXgM-unsplash@3x.png",
      "statustext": "Events",
      "navigateTo": "DocumentsScreen"
    },
    {
      "containerimage":
          "assets/images/romain-dancre-doplSDELX7E-unsplash@3x.png",
      "statustext": "Documents",
      "navigateTo": "DocumentsScreen"
    },
    {
      "containerimage":
          "assets/images/zhang-shaoqi-PdUACzBJP-Y-unsplash@3x.png",
      "statustext": "Videos",
      "navigateTo": "DocumentsScreen"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      color: whitish,
      child: Scaffold(
        key: _key,
        backgroundColor: transparentcolor,
        appBar: AppBar(
          backgroundColor: transparentcolor,
          elevation: 0,
          leadingWidth: 70,
          leading: GestureDetector(
            onTap: () {
              _key.currentState!.openDrawer();
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
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => SettingsScreen());
                },
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: whitecolor,
                  ),
                  child: Image.asset(
                    "assets/images/Group 1289@3x.png",
                    scale: 2.5,
                  ),
                ),
              ),
            ),
          ],
        ),
        drawer: DrawerScreen(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                20.verticalSpace,
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: white,
                    suffixIconConstraints: BoxConstraints(minWidth: 50),
                    suffixIcon: Image.asset(
                      "assets/images/Group 1290@3x.png",
                      scale: 3.5,
                    ),
                    hintText: "Search here …..",
                    hintStyle: medium15greywithOpacity,
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
                20.verticalSpace,
                Container(
                  width: 1.sw,
                  height: 0.15.sh,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 10);
                    },
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: false,
                    itemCount: StatusWidgetDetails.length,
                    itemBuilder: (BuildContext context, i) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => routingscreennames[i]),
                          // );
                          log('ujijiuhiu: $i');
                          if (i == 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DocumentsScreen(
                                    value: 'home$i',
                                  ),
                                ));
                          } else if (i == 1) {
                            // log('ujijiukjjkjkhiu: $i');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideoScreen(
                                        value: 'home$i',
                                      )),
                            );
                          } else if (i == 2) {
                            // log('ujijiukjjkjkhiu: $i');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MagzineScreen(
                                        value: 'home$i',
                                      )),
                            );
                          } else if (i == 3) {
                            // log('ujijiukjjkjkhiu: $i');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsAndEventsScreen(
                                        value: 'home$i',
                                      )),
                            );
                          }
                        },
                        child: StatusWidget(
                          containerimage: StatusWidgetDetails[i]
                              ["containerimage"],
                          statustext: StatusWidgetDetails[i]["statustext"],
                          index: i,
                        ),
                      );
                    },
                  ),
                ),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: "newtag",
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          "News & Events",
                          style: textroboto20,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => NewsAndEventsScreen(
                              value: "",
                            ));
                      },
                      child: Text(
                        "View all",
                        style: txtstylebluehshade14,
                      ),
                    )
                  ],
                ),
                15.verticalSpace,
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
                            )
                          ],
                        ),
                        15.verticalSpace,
                        GestureDetector(
                          onTap: () {
                            Get.to(() => NewsAndEventsDetailsScreen(),
                                duration: Duration(seconds: 1),
                                transition: Transition.fadeIn);
                          },
                          child: StaggeredGrid.count(
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
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/Group 1440@3x.png"),
                                        fit: BoxFit.fill),
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
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/Group 1440@3x.png"),
                                        fit: BoxFit.fill),
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
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/Group 1440@3x.png"),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              StaggeredGridTile.count(
                                crossAxisCellCount: 5,
                                mainAxisCellCount: 1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 170.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.r),
                                        ),
                                        color: black,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/Group 1440@3x.png"),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    Container(
                                      width: 170.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10.r),
                                        ),
                                        color: black,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/Group 1440@3x.png"),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Feed",
                    style: textroboto20,
                  ),
                ),
                15.verticalSpace,
                Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.r),
                    child: Column(
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
                                    "assets/images/Ellipse 68-1@3x.png",
                                  ),
                                ),
                              ),
                            ),
                            15.horizontalSpace,
                            Text(
                              "Admin",
                              style: txtstyleblue17,
                            )
                          ],
                        ),
                        15.verticalSpace,
                        Container(
                          width: 0.9.sw,
                          height: 250.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: whitecolor,
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/Rectangle 179@3x.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.r, bottom: 10.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset(
                                  "assets/images/Group 1435@3x.png",
                                  scale: 2.5,
                                ),
                              ],
                            ),
                          ),
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
                Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.r),
                    child: Column(
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
                                    "assets/images/Ellipse 68-1@3x.png",
                                  ),
                                ),
                              ),
                            ),
                            15.horizontalSpace,
                            Hero(
                              tag: "Video",
                              child: Material(
                                type: MaterialType.transparency,
                                child: Text(
                                  "Admin",
                                  style: txtstyleblue17,
                                ),
                              ),
                            )
                          ],
                        ),
                        15.verticalSpace,
                        GestureDetector(
                          onTap: () {
                            Get.to(() => VidePalayerScreen(),
                                duration: Duration(seconds: 1),
                                transition: Transition.fadeIn);
                          },
                          child: Container(
                            width: 0.9.sw,
                            height: 250.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: whitecolor,
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Group 1440@3x.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/Group 12950@3x.png",
                                  scale: 3.5,
                                ),
                              ],
                            ),
                          ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatusWidget extends StatelessWidget {
  var statustext;
  int index;

  String containerimage;
  // final VoidCallback? route;

  StatusWidget({
    this.statustext,
    required this.index,
    required this.containerimage,
    // required this.route,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(containerimage),
            ),
          ),
        ),
        10.verticalSpace,
        Hero(
          transitionOnUserGestures: true,
          tag: ValueKey('home$index'),
          child: Text(
            statustext,
            style: textroboto14blue,
          ),
        )
      ],
    );
  }
}
