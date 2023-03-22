import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
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
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
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
          ],
        ),
      ),
    );
  }
}
