import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'Drawer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool isVisible = true;
  List<Map<String, dynamic>> detailsnotification = [
    {
      "userimage": "assets/images/Ellipse 68@3x.png",
      "attacheditemimage": "assets/images/Rectangle 990@3x.png",
      "isselected": true,
      "type": "video",
      "documenttype": "Admin added a Videos"
    },
    {
      "userimage": "assets/images/Ellipse 68-1@3x.png",
      "attacheditemimage": "assets/images/Group 1440@3x.png",
      "isselected": false,
      "type": "image",
      "documenttype": "Admin added a Videos"
    },
    {
      "userimage": "assets/images/Group 1433@3x1.png",
      "attacheditemimage": "assets/images/Rectangle 990@3x.png",
      "isselected": true,
      "type": "document",
      "documenttype": "Document Uploaded"
    },
    {
      "userimage": "assets/images/Group 1433@3x.png",
      "attacheditemimage": "assets/images/NoPath@3x.png",
      "isselected": false,
      "type": "document",
      "documenttype": "Magzine Uploaded"
    },
    {
      "userimage": "assets/images/zhang-shaoqi-PdUACzBJP-Y-unsplash@3x.png",
      "attacheditemimage": "assets/images/Rectangle 990@3x.png",
      "isselected": true,
      "type": "video",
      "documenttype": "Magzine Uploaded"
    },
    {
      "userimage": "assets/images/romain-dancre-doplSDELX7E-unsplash@3x.png",
      "attacheditemimage": "assets/images/Group 1440@3x.png",
      "isselected": false,
      "type": "video",
      "documenttype": "Admin added a Event"
    },
    {
      "userimage": "assets/images/Ellipse 68@3x.png",
      "attacheditemimage": "assets/images/NoPath@3x.png",
      "isselected": true,
      "type": "document",
      "documenttype": "Document Uploaded"
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
              Get.to(() => DrawerScreen());
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
          title: Text(
            "NOTIFICATION",
            style: textroboto18,
          ),
          centerTitle: true,
        ),
        drawer: DrawerScreen(),
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
                        type: detailsnotification[i]["type"],
                        documenttype: detailsnotification[i]["documenttype"],
                      );

                      //  Visibility(
                      //   visible: detailsnotification[i]['isselected'] == true? true:false,
                      //   child: NotificationWidget(
                      //     attacheditemimage: detailsnotification[i]["attacheditemimage"],
                      //     userimage: detailsnotification[i]["userimage"],
                      //   ),
                      // );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  bool isVisible = true;
  String userimage;
  final type;
  var documenttype;

  String attacheditemimage;

  NotificationWidget({
    required this.userimage,
    required this.attacheditemimage,
    required this.type,
    this.documenttype,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slidable(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(documenttype, style: txtstyleblue16),
                            Text('Lorem ipsum dolor sit amet...', style: medium13black),
                            10.verticalSpace,
                            type == "document"
                                ? Container(
                                    height: 35.h,
                                    width: 160.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: bluishshade),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          "assets/images/pdf@3x.png",
                                          scale: 3.5,
                                        ),
                                        Text(
                                          "Document.PDF",
                                          style: fontsize11,
                                        ),
                                        Image.asset(
                                          "assets/images/Group 1442@3x.png",
                                          scale: 3.5,
                                        )
                                      ],
                                    ),
                                  )
                                : Container()
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
                      type == "document"
                          ? Container(
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
                            )
                          : Container(),
                      type == "video"
                          ? Container(
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
                              ))
                          : type == "image"
                              ? Container(
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
                                )
                              : Container()
                    ],
                  )
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
