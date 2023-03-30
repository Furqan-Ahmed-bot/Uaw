import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/AttendingEventsDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendingEventScreen extends StatefulWidget {
  const AttendingEventScreen({super.key});

  @override
  State<AttendingEventScreen> createState() => _AttendingEventScreenState();
}

class _AttendingEventScreenState extends State<AttendingEventScreen> {
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
            "ATTENDING EVENTS",
            style: textroboto18,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                15.verticalSpace,
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext contex, i) {
                      return GestureDetector(
                          onTap: () {
                            Get.to(() => AttendingEventDetailsScreen(), duration: Duration(seconds: 1), transition: Transition.fadeIn);
                          },
                          child: Newsandeventswidget());
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Newsandeventswidget extends StatelessWidget {
  const Newsandeventswidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    ),
                    Spacer(),
                    Image.asset(
                      "assets/images/Group 1333@3x.png",
                      scale: 3.5,
                    )
                  ],
                ),
                15.verticalSpace,
                StaggeredGrid.count(
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
                          image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
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
                          image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
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
                          image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
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
                              image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                            ),
                          ),
                          Container(
                            width: 170.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.r),
                              ),
                              color: black,
                              image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                            ),
                          ),
                        ],
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
        15.verticalSpace,
      ],
    );
  }
}
