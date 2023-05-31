import 'dart:convert';

import 'package:_uaw/Auth/APIService/API.dart';
import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TermAndCondicitonScreen extends StatefulWidget {
  final String value;
  const TermAndCondicitonScreen({super.key, required this.value});

  @override
  State<TermAndCondicitonScreen> createState() => _TermAndCondicitonScreenState();
}

class _TermAndCondicitonScreenState extends State<TermAndCondicitonScreen> with SingleTickerProviderStateMixin {
  late final termsandconditionsdata;
  bool _isLoading = false;
  TermsandConditions() async {
    termsandconditionsdata = await ApiService().getTerms();
    setState(() {
      _isLoading = true;
    });
    print(json.encode(termsandconditionsdata));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TermsandConditions();
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
              },
              child: Image.asset(
                "assets/images/Group 1430@3x.png",
                scale: 2.5,
              ),
            ),
          ),
          title: Hero(
            transitionOnUserGestures: true,
            tag: "term",
            child: Text(
              "TERMS AND CONDITIONS",
              style: textroboto18,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: SingleChildScrollView(
            child: _isLoading == false
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      40.verticalSpace,
                      Text(
                        termsandconditionsdata[0]["contentType"].toString(),
                        style: txtstyleblack20Bold,
                      ),
                      20.verticalSpace,
                      Text(
                        termsandconditionsdata[0]["title"].toString(),
                        style: txtstyleblack15regular,
                      ),
                      50.verticalSpace,
                      // Text(
                      //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae vulputate velit. Nulla facilisi. Fusce interdum ornare arcu, quis accumsan sapien tincidunt vel. Donec tempus nibh a lectus eleifend, at aliquam quam pharetra. Aliquam blandit risus nunc, viverra porttitor ex mattis et. Maecenas accumsan felis et sem pellentesque faucibus. Aliquam facilisis facilisis est, vitae ultricies tortor auctor eget. Aenean ac metus porttitor, interdum mauris iaculis, commodo erat.",
                      //   style: txtstyleblack15regular,
                      // ),
                      // 20.verticalSpace,
                      // Text(
                      //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae vulputate velit. Nulla facilisi. Fusce interdum ornare arcu, quis accumsan sapien tincidunt vel. Donec tempus nibh a lectus eleifend, at aliquam quam pharetra. Aliquam blandit risus nunc, viverra porttitor ex mattis et. Maecenas accumsan felis et sem pellentesque faucibus. Aliquam facilisis facilisis est, vitae ultricies tortor auctor eget. Aenean ac metus porttitor, interdum mauris iaculis, commodo erat.",
                      //   style: txtstyleblack15regular,
                      // ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
