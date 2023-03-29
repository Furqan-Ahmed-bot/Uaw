import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
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
                        image: DecorationImage(image: AssetImage("assets/images/Group 1433@3x1.png"), fit: BoxFit.fill),
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
                          Row(
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
                          30.verticalSpace,
                          Row(
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
                          30.verticalSpace,
                          Row(
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
                          30.verticalSpace,
                          Row(
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
                          30.verticalSpace,
                          Row(
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
                          30.verticalSpace,
                          Row(
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Stack(
      //   children: [
      //     Container(
      //       height: 1.sh,
      //       width: 0.8.sw,
      //       child: Image.asset(
      //         "assets/images/Rectangle 74@3x.png",
      //         fit: BoxFit.fill,
      //       ),
      //     ),
      //     Positioned(
      //       child: Container(
      //         decoration: BoxDecoration(
      //           gradient: LinearGradient(
      //             begin: Alignment.topCenter,
      //             end: Alignment.bottomCenter,
      //             colors: [Color(0xff000000E6), Color(0xff04366BCC)],
      //           ),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    ]);
  }
}
