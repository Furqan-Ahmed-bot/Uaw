import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MagzineScreen extends StatefulWidget {
  final String value;
  const MagzineScreen({super.key, required this.value});

  @override
  State<MagzineScreen> createState() => _MagzineScreenState();
}

class _MagzineScreenState extends State<MagzineScreen> {
  List<String> imagelist = ["assets/images/zhang-shaoqi-PdUACzBJP-Y-unsplash@2x.png", "assets/images/zhang-shaoqi-PdUACzBJP-Y-unsplash@2x.png"];
  String now = DateFormat("yyyy-MM-dd").format(DateTime.now());
  int i = 0;
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
          title: Hero(
            transitionOnUserGestures: true,
            tag: ValueKey(widget.value),
            child: Text(
              "MAGAZINES",
              style: textroboto18,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Column(
            children: [
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
                      StaggeredGrid.count(
                        crossAxisCount: 1,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        children: [
                          Container(
                            width: 1.sw,
                            height: 350.h,
                            child: StaggeredGridTile.count(
                              crossAxisCellCount: 2,
                              mainAxisCellCount: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 175.w,
                                    height: 200.h,
                                    child: StaggeredGridTile.count(
                                      crossAxisCellCount: 1,
                                      mainAxisCellCount: 1,
                                      child: Container(
                                        width: 175.w,
                                        height: 248.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.r),
                                          image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                          color: black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 170.w,
                                    height: 350.h,
                                    child: StaggeredGridTile.count(
                                      crossAxisCellCount: 1,
                                      mainAxisCellCount: 1,
                                      child: Container(
                                        width: 175.w,
                                        height: 248.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.r),
                                          image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                          color: black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
    );
  }
}
