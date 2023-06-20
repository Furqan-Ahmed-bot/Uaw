// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:io';

import 'package:_uaw/Controllers/feedscontroller.dart';
import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/Documents.dart';
import 'package:_uaw/HomeScreens/Drawer.dart';
import 'package:_uaw/HomeScreens/DrawerVideoPlayer.dart';
import 'package:_uaw/HomeScreens/Magzines.dart';
import 'package:_uaw/HomeScreens/NavBar.dart';
import 'package:_uaw/HomeScreens/NewsAndEventDetails.dart';
import 'package:_uaw/HomeScreens/Settings.dart';
import 'package:_uaw/HomeScreens/VideoScreen.dart';
import 'package:_uaw/HomeScreens/VideosScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Auth/APIService/API.dart';
import '../Controller.dart';
import '../Controllers/eventcontroller.dart';
import '../Controllers/usercontroller.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

import '../downloadfiles.dart';

class HomeScreen extends StatefulWidget {
  String? cameFrom;
  HomeScreen({
    super.key,
    this.cameFrom,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic documentUrl;
  bool isDrawerOpen = false;

  void toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
    });
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final bottomcontroller = Get.put(BottomController());
  final eventcontroller = Get.put(EventController());
  final feedController = Get.put(feedsController());
  List AllFeeds = [];

  final userController = Get.put(UserController());
  UserController cnt = Get.find();
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
    {"containerimage": "assets/images/romain-dancre-doplSDELX7E-unsplash@3x.png", "statustext": "Documents", "navigateTo": "DocumentsScreen"},
    {"containerimage": "assets/images/zhang-shaoqi-PdUACzBJP-Y-unsplash@3x.png", "statustext": "Videos", "navigateTo": "DocumentsScreen"},
    {"containerimage": "assets/images/krakenimages-Y5bvRlcCx8k-unsplash@3x.png", "statustext": "Magazines", "navigateTo": "DocumentsScreen"},
    {"containerimage": "assets/images/md-duran-rE9vgD_TXgM-unsplash@3x.png", "statustext": "Events", "navigateTo": "DocumentsScreen"},
  ];

  void searchevent(query) {
    AllFeeds = feedController.AllFeeds;
    if (query.isEmpty) {
      setState(() {
        feedController.feedsData = feedController.AllFeeds;
      });
    } else {
      feedController.feedsData = AllFeeds.where((item) => (item['title'].toLowerCase()).contains(query)).toList();

      feedController.feedsData;
    }
  }

  @override
  void initState() {
    // SchedulerBinding.instance.addPostFrameCallback((_) {

    //   print("SchedulerBinding");
    // });
    if (widget.cameFrom == '') {
      Future.delayed(Duration.zero, () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ApiService().Events(context);
          ApiService().getFeeds();
        });
      });
    } else {
      // WidgetsBinding.instance.addPostFrameCallback((_) {

      // });
      ApiService().Events(context);
      ApiService().getFeeds();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Container(
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
              child: SingleChildScrollView(child: GetBuilder<EventController>(
                builder: (eventController) {
                  eventController.EventsData;
                  return eventController.isLoding && eventcontroller.MyEvents.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            20.verticalSpace,
                            Container(
                              child: SizedBox(
                                height: 50.h,
                                width: 1.sw,
                                child: TextFormField(
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      searchevent(value);
                                    });
                                  },
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
                              ),
                            ),
                            20.verticalSpace,
                            SizedBox(
                              width: 1.sw,
                              height: 0.15.sh,
                              child: ListView.separated(
                                separatorBuilder: (BuildContext context, int index) {
                                  return const SizedBox(width: 23);
                                },
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: false,
                                itemCount: StatusWidgetDetails.length,
                                itemBuilder: (BuildContext context, i) {
                                  return GestureDetector(
                                    onTap: () {
                                      bottomcontroller.navBarChange(1);
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => NavBarScreen()),
                                        );
                                        // log('ujijiukjjkjkhiu: $i');
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) => NewsAndEventsScreen(
                                        //             value: 'home$i',
                                        //           )),
                                        // );
                                      }
                                    },
                                    child: StatusWidget(
                                      containerimage: StatusWidgetDetails[i]["containerimage"],
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
                                    bottomcontroller.navBarChange(1);
                                    Get.to(
                                      () => NavBarScreen(),
                                      duration: Duration(seconds: 1),
                                      transition: Transition.fadeIn,
                                    );
                                  },
                                  child: Text(
                                    "View all",
                                    style: txtstylebluehshade14,
                                  ),
                                )
                              ],
                            ),
                            15.verticalSpace,
                            eventController.EventsData.isNotEmpty
                                ? Container(
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
                                                      "assets/images/Ellipse 68-1@3x.png",
                                                    ),

                                                    //     NetworkImage(
                                                    //   "https://uaw-api.thesuitchstaging.com:3090/${eventController.EventsData[0]['file'][0]['file']}",
                                                    // ),
                                                  ),
                                                ),
                                              ),
                                              10.horizontalSpace,
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    eventController.EventsData[0]['user']['name'],
                                                    style: txtstyleblue17,
                                                  ),
                                                  5.verticalSpace,
                                                  Text(eventController.EventsData[0]['date'].toString()

                                                      // DateFormat(
                                                      //   "MM-dd-yyyy",
                                                      // ).format(
                                                      //   DateTime.now(),
                                                      // ),
                                                      // style: textroboto12,
                                                      ),
                                                ],
                                              )
                                            ],
                                          ),
                                          15.verticalSpace,
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                  () => NewsAndEventsDetailsScreen(
                                                        name: eventController.EventsData[0]['user']['name'],
                                                        date: eventController.EventsData[0]['createdAt'].toString(),
                                                        description: eventController.EventsData[0]['description'],
                                                        timee: eventController.EventsData[0]['createdAt'].toString(),
                                                        title: eventController.EventsData[0]['title'],
                                                        location: eventController.EventsData[0]['location'].toString(),
                                                        eventimage: eventController.EventsData[0]['file'].length == 0
                                                            ? null
                                                            : eventController.EventsData[0]['file'][0]['file'],
                                                        eventid: eventController.EventsData[0]['_id'],
                                                      ),
                                                  duration: Duration(seconds: 1),
                                                  transition: Transition.fadeIn);
                                            },
                                            child: Container(
                                              child: eventController.EventsData[0]['file'].length == 0
                                                  ? StaggeredGrid.count(
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
                                                              image: const DecorationImage(
                                                                  image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                                            ),
                                                          ),
                                                        ),
                                                        StaggeredGridTile.count(
                                                          crossAxisCellCount: 1,
                                                          mainAxisCellCount: 1,
                                                          child: Container(
                                                            width: 115.w,
                                                            height: 135.h,
                                                            decoration: const BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
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
                                                              image: const DecorationImage(
                                                                  image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                                            ),
                                                          ),
                                                        ),
                                                        StaggeredGridTile.count(
                                                          crossAxisCellCount: 5,
                                                          mainAxisCellCount: 1,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Container(
                                                                width: 170.w,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                    bottomLeft: Radius.circular(10.r),
                                                                  ),
                                                                  color: black,
                                                                  image: const DecorationImage(
                                                                      image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 170.w,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                    bottomRight: Radius.circular(10.r),
                                                                  ),
                                                                  color: black,
                                                                  image: const DecorationImage(
                                                                      image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Image(
                                                      image: NetworkImage(
                                                          "https://uaw-api.thesuitchstaging.com:3090/${eventController.EventsData[0]['file'][0]['file']}")),
                                            ),

                                            // StaggeredGrid.count(
                                            //   crossAxisCount: 3,
                                            //   mainAxisSpacing: 5,
                                            //   crossAxisSpacing: 5,
                                            //   children: [
                                            //     StaggeredGridTile.count(
                                            //       crossAxisCellCount: 1,
                                            //       mainAxisCellCount: 1,
                                            //       child: Container(
                                            //         width: 115.w,
                                            //         height: 135.h,
                                            //         decoration: BoxDecoration(
                                            //           borderRadius: BorderRadius.only(
                                            //             topLeft: Radius.circular(10.r),
                                            //           ),
                                            //           color: black,
                                            //           image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                            //         ),
                                            //       ),
                                            //     ),
                                            //     StaggeredGridTile.count(
                                            //       crossAxisCellCount: 1,
                                            //       mainAxisCellCount: 1,
                                            //       child: Container(
                                            //         width: 115.w,
                                            //         height: 135.h,
                                            //         decoration: BoxDecoration(
                                            //           image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                            //           color: black,
                                            //         ),
                                            //       ),
                                            //     ),
                                            //     StaggeredGridTile.count(
                                            //       crossAxisCellCount: 1,
                                            //       mainAxisCellCount: 1,
                                            //       child: Container(
                                            //         width: 115.w,
                                            //         height: 135.h,
                                            //         decoration: BoxDecoration(
                                            //           color: black,
                                            //           borderRadius: BorderRadius.only(
                                            //             topRight: Radius.circular(10.r),
                                            //           ),
                                            //           image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                            //         ),
                                            //       ),
                                            //     ),
                                            //     StaggeredGridTile.count(
                                            //       crossAxisCellCount: 5,
                                            //       mainAxisCellCount: 1,
                                            //       child: Row(
                                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //         children: [
                                            //           Container(
                                            //             width: 170.w,
                                            //             decoration: BoxDecoration(
                                            //               borderRadius: BorderRadius.only(
                                            //                 bottomLeft: Radius.circular(10.r),
                                            //               ),
                                            //               color: black,
                                            //               image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                            //             ),
                                            //           ),
                                            //           Container(
                                            //             width: 170.w,
                                            //             decoration: BoxDecoration(
                                            //               borderRadius: BorderRadius.only(
                                            //                 bottomRight: Radius.circular(10.r),
                                            //               ),
                                            //               color: black,
                                            //               image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                            //             ),
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                          ),
                                          10.verticalSpace,
                                          Row(
                                            children: [
                                              Container(
                                                constraints: BoxConstraints(maxWidth: 0.8.sw),
                                                child: Text(
                                                  eventController.EventsData[0]['description'],
                                                  // UserController.event.data![0].description
                                                  //     .toString(),
                                                  style: textroboto15,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          20.verticalSpace,
                                        ],
                                      ),
                                    ),
                                  )
                                : Text(
                                    "No upcoming events",
                                    style: textroboto20,
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
                            GetBuilder<feedsController>(
                              builder: (feedsController) {
                                return feedsController.isloading && feedsController.feedsData.isEmpty
                                    ? Center(child: CircularProgressIndicator())
                                    : Column(
                                        children: [
                                          ListView.builder(
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: feedsController.feedsData.length,
                                              itemBuilder: (BuildContext, index) {
                                                fileName = feedsController.feedsData[index]["file"][0];
                                                videoFile = feedsController.feedsData[index]["file"][0];

                                                String filename2 = fileName.split('/').last;
                                                String videoFileName = fileName.split('/').last;
                                                return Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        feedsController.feedsData[index]["filepath"][0].endsWith(".mp4")
                                                            ? Get.to(
                                                                () => DrawerVideoPlayerSvreen(vurl: feedsController.feedsData[index]["filepath"][0]))
                                                            : null;
                                                      },
                                                      child: Container(
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
                                                                    feedsController.feedsData[index]["user"]["name"],
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
                                                                  image: feedsController.feedsData[index]["filepath"][0].endsWith(".pdf")
                                                                      ? DecorationImage(
                                                                          image: NetworkImage(
                                                                              "https://uaw-api.thesuitchstaging.com/Uploads/${feedsController.feedsData[index]["coverImage"]["file"]}"),
                                                                          fit: BoxFit.fill,
                                                                        )
                                                                      : feedsController.feedsData[index]["filepath"][0].endsWith(".mp4")
                                                                          ? DecorationImage(
                                                                              image: NetworkImage(
                                                                                  "https://uaw-api.thesuitchstaging.com/Uploads/${feedsController.feedsData[index]["coverImage"]["file"]}"),
                                                                              fit: BoxFit.fill,
                                                                            )
                                                                          : feedsController.feedsData[index]["filepath"][0].endsWith(".docx") ||
                                                                                  feedsController.feedsData[index]["filepath"][0].endsWith(".doc")
                                                                              ? DecorationImage(
                                                                                  image: NetworkImage(
                                                                                      "https://uaw-api.thesuitchstaging.com/Uploads/${feedsController.feedsData[index]["coverImage"]["file"]}"),
                                                                                  fit: BoxFit.fill,
                                                                                )
                                                                              : DecorationImage(
                                                                                  image: AssetImage("assets/images/Rectangle 179@3x.png"),
                                                                                  fit: BoxFit.fill,
                                                                                ),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(right: 10.r, bottom: 10.r),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                    children: [
                                                                      feedsController.feedsData[index]["filepath"][0].endsWith(".mp4")
                                                                          ? Container()
                                                                          : GestureDetector(
                                                                              onTap: () {
                                                                                if (feedsController.feedsData[index]["file"][0].endsWith('.docx') ||
                                                                                    feedsController.feedsData[index]["file"][0].endsWith('.doc')) {
                                                                                  showDialog(
                                                                                      context: context,
                                                                                      builder: (context) => DownloadingDialogFile(
                                                                                          url:
                                                                                              'https://uaw-api.thesuitchstaging.com/Uploads/${feedsController.feedsData[index]["file"][0]}'));

                                                                                  _downloadDocument(
                                                                                      feedsController.feedsData[index]["file"][0], filename2);
                                                                                } else {
                                                                                  showDialog(
                                                                                      context: context,
                                                                                      builder: (context) => DownloadingDialogFile(
                                                                                          url:
                                                                                              'https://uaw-api.thesuitchstaging.com/Uploads/${feedsController.feedsData[index]["file"][0]}'));

                                                                                  _downloadDocument(
                                                                                      feedsController.feedsData[index]["file"][0], filename2);

                                                                                  // showDialog(
                                                                                  //   context: context,
                                                                                  //   builder: (context) => const DownloadingDialog(),
                                                                                  // );
                                                                                }
                                                                              },
                                                                              child: Image.asset(
                                                                                "assets/images/Group 1435@3x.png",
                                                                                scale: 2.5,
                                                                              ),
                                                                            ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              10.verticalSpace,
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    constraints: BoxConstraints(maxWidth: 200),
                                                                    child: Text(
                                                                      feedsController.feedsData[index]["title"],
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: textroboto15,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              20.verticalSpace,
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    15.verticalSpace,
                                                  ],
                                                );
                                              })
                                        ],
                                      );
                              },
                            ),
                            15.verticalSpace,
                            // Container(
                            //   width: 1.sw,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10.r),
                            //     color: white,
                            //   ),
                            //   child: Padding(
                            //     padding: EdgeInsets.symmetric(horizontal: 20.r),
                            //     child: Column(
                            //       children: [
                            //         20.verticalSpace,
                            //         Row(
                            //           children: [
                            //             Container(
                            //               width: 60.h,
                            //               height: 60.h,
                            //               decoration: BoxDecoration(
                            //                 shape: BoxShape.circle,
                            //                 image: DecorationImage(
                            //                   image: AssetImage(
                            //                     "assets/images/Ellipse 68-1@3x.png",
                            //                   ),
                            //                 ),
                            //               ),
                            //             ),
                            //             15.horizontalSpace,
                            //             Hero(
                            //               tag: "Video",
                            //               child: Material(
                            //                 type: MaterialType.transparency,
                            //                 child: Text(
                            //                   "Admin",
                            //                   style: txtstyleblue17,
                            //                 ),
                            //               ),
                            //             )
                            //           ],
                            //         ),
                            //         15.verticalSpace,
                            //         GestureDetector(
                            //           onTap: () {
                            //             Get.to(() => VidePalayerScreen(), duration: Duration(seconds: 1), transition: Transition.fadeIn);
                            //           },
                            //           child: Container(
                            //             width: 0.9.sw,
                            //             height: 250.h,
                            //             decoration: BoxDecoration(
                            //               borderRadius: BorderRadius.circular(10.r),
                            //               color: whitecolor,
                            //               image: DecorationImage(
                            //                 image: AssetImage("assets/images/Group 1440@3x.png"),
                            //                 fit: BoxFit.fill,
                            //               ),
                            //             ),
                            //             child: Row(
                            //               mainAxisAlignment: MainAxisAlignment.center,
                            //               crossAxisAlignment: CrossAxisAlignment.center,
                            //               children: [
                            //                 Image.asset(
                            //                   "assets/images/Group 12950@3x.png",
                            //                   scale: 3.5,
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //         10.verticalSpace,
                            //         Text(
                            //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae vulputate velit. Nulla facilisi. Fusce interdum ornare arcu, quis",
                            //           style: textroboto15,
                            //         ),
                            //         20.verticalSpace,
                            //       ],
                            //     ),
                            //   ),
                            // ),

                            150.verticalSpace,
                          ],
                        );
                },
              ))),
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

dynamic fileName;
dynamic videoFile;
Future<void> _downloadDocument(String url, String filename) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();

    final filePath = '${appDocumentsDirectory.path}/$filename';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    // Open the document
    final documentUrl = file.path;
    if (await canLaunch(documentUrl)) {
      await launch(documentUrl);
    } else {
      print('Could not open the document');
    }

    print('Document downloaded to: $filePath');
    // Handle the downloaded file, e.g., open or share it
  } else {
    print('Failed to download the document. Status code: ${response.statusCode}');
    // Handle error, such as displaying an error message to the user
  }
}
