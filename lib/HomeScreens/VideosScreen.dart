import 'package:_uaw/Controllers/videocontroller.dart';
import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/Drawer.dart';
import 'package:_uaw/HomeScreens/DrawerVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Auth/APIService/API.dart';
import '../Controller.dart';
import 'NavBar.dart';

class VideoScreen extends StatefulWidget {
  final String value;
  const VideoScreen({super.key, required this.value});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final bottomcontroller = Get.put(BottomController());
  String now = DateFormat("yyyy-MM-dd").format(DateTime.now());
  List VideoDetails = [
    {"userimage": "assets/images/Ellipse 68-1@3x.png"},
    {"userimage": "assets/images/Ellipse 68@3x.png"},
    {"userimage": "assets/images/krakenimages-Y5bvRlcCx8k-unsplash@3x.png"},
  ];

  void initState() {
    ApiService().getVideo();

    super.initState();
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
                if (bottomcontroller.navigationBarIndexValue != 0) {
                  bottomcontroller.navBarChange(0);
                } else {
                  Get.to(() => DrawerScreen());
                }
              },
              child: Image.asset(
                "assets/images/Group 1430@3x.png",
                scale: 2.5,
              ),
            ),
          ),
          title: Hero(
            transitionOnUserGestures: true,
            tag: ValueKey(widget.value),
            child: Text(
              "VIDEOS",
              style: textroboto18,
            ),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<VideoController>(
          builder: (videocontroller) {
            return videocontroller.isLoding ?? videocontroller.VideoData.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.r),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          35.verticalSpace,
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: videocontroller.VideoData.length,
                              itemBuilder: (BuildContext context, index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => DrawerVideoPlayerSvreen());
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
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        videocontroller.VideoData[index]["user"]["name"],
                                                        style: txtstyleblue17,
                                                      ),
                                                      5.verticalSpace,
                                                      Text(
                                                        DateFormat(
                                                          videocontroller.VideoData[index]["user"]["date"],
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
                                              Container(
                                                width: 0.9.sw,
                                                height: 250.h,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.r),
                                                  color: whitecolor,
                                                  image: DecorationImage(
                                                    image: AssetImage("assets/images/Group 1440@3x.png"),
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
                                              10.verticalSpace,
                                              Row(
                                                children: [
                                                  Text(
                                                    videocontroller.VideoData[index]["title"],
                                                    style: textroboto15,
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

                                ;
                              })
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class VideoWidget extends StatelessWidget {
  String userimage;
  VideoWidget({
    required this.userimage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => DrawerVideoPlayerSvreen());
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
                              userimage,
                            ),
                          ),
                        ),
                      ),
                      15.horizontalSpace,
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
                  Container(
                    width: 0.9.sw,
                    height: 250.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: whitecolor,
                      image: DecorationImage(
                        image: AssetImage("assets/images/Group 1440@3x.png"),
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
        ),
        15.verticalSpace,
      ],
    );
  }
}
