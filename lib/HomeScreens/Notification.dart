import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List detailsnotification = [
    {"userimage": "assets/images/Ellipse 68@3x.png", "attacheditemimage": "assets/images/Rectangle 990@3x.png"},
    {"userimage": "assets/images/Ellipse 68-1@3x.png", "attacheditemimage": "assets/images/Group 1440@3x.png"},
    {"userimage": "assets/images/Group 1433@3x1.png", "attacheditemimage": "assets/images/Rectangle 990@3x.png"},
    {"userimage": "assets/images/Group 1433@3x.png", "attacheditemimage": "assets/images/Group 1440@3x.png"},
    {"userimage": "assets/images/zhang-shaoqi-PdUACzBJP-Y-unsplash@3x.png", "attacheditemimage": "assets/images/Rectangle 990@3x.png"},
    {"userimage": "assets/images/romain-dancre-doplSDELX7E-unsplash@3x.png", "attacheditemimage": "assets/images/Group 1440@3x.png"},
    {"userimage": "assets/images/Ellipse 68@3x.png", "attacheditemimage": "assets/images/Rectangle 990@3x.png"},
  ];

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
            "NOTIFICATION",
            style: textroboto18,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                15.verticalSpace,
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: detailsnotification.length,
                    itemBuilder: (BuildContext context, i) {
                      return NotificationWidget(
                        attacheditemimage: detailsnotification[i]["attacheditemimage"],
                        userimage: detailsnotification[i]["userimage"],
                      );
                    }),
                // NotificationWidget(),

                // ListView.builder(
                //     physics: NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     itemCount: imagelist.length,
                //     itemBuilder: (BuildContext context, i) {
                //       return Magzinewidget(
                //         userimage: imagelist[i]["userimage"],
                //       );
                //     })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  String userimage;

  String attacheditemimage;

  NotificationWidget({
    required this.userimage,
    required this.attacheditemimage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      useTextDirection: false,
      direction: Axis.horizontal,
      closeOnScroll: true,
      endActionPane: ActionPane(
        dragDismissible: true,
        extentRatio: 0.3,
        children: [
          25.horizontalSpace,
          Image.asset(
            "assets/images/Icon metro-bin@3x.png",
            scale: 2.5,
          )
        ],
        motion: ScrollMotion(),
      ),
      child: Container(
        // margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(
                      userimage,
                    ))),
              ),
              10.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 0.57.sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Admin added a Videos', style: txtstyleblue16),
                        Text('Lorem ipsum dolor sit amet...', style: medium13black),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "30m ago",
                    style: medium13black,
                  ),
                  10.verticalSpace,
                  Container(
                    width: 35.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      image: DecorationImage(
                          image: AssetImage(
                            attacheditemimage,
                          ),
                          fit: BoxFit.fill),
                    ),
                    child: Image.asset(
                      "assets/images/Group 1295@3x.png",
                      scale: 15,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
