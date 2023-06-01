import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Controller.dart';

class DocumentsScreen extends StatefulWidget {
  final String value;
  const DocumentsScreen({super.key, required this.value});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> with SingleTickerProviderStateMixin {


  list 
  final bottomcontroller = Get.put(BottomController());
  String now = DateFormat("yyyy-MM-dd").format(DateTime.now());
  List DocumentDetails = [
    {"userimage": "assets/images/Ellipse 68-1@3x.png"},
    {"userimage": "assets/images/Ellipse 68@3x.png"},
    {"userimage": "assets/images/krakenimages-Y5bvRlcCx8k-unsplash@3x.png"},
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
                if (bottomcontroller.navigationBarIndexValue != 0) {
                  bottomcontroller.navBarChange(0);
                } else {
                  Get.back();
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
              "DOCUMENTS",
              style: textroboto18,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                35.verticalSpace,
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: DocumentDetails.length,
                    itemBuilder: (BuildContext context, i) {
                      return DocumentWidget(
                        userimage: DocumentDetails[i]["userimage"],
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DocumentWidget extends StatelessWidget {
  String userimage;
  DocumentWidget({
    required this.userimage,
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
                            "MMM dd yyyy",
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
      ],
    );
  }
}
