import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PrivicyAndPolicyScreen extends StatefulWidget {
  final String value;
  const PrivicyAndPolicyScreen({super.key, required this.value});

  @override
  State<PrivicyAndPolicyScreen> createState() => _PrivicyAndPolicyScreenState();
}

class _PrivicyAndPolicyScreenState extends State<PrivicyAndPolicyScreen>
    with SingleTickerProviderStateMixin {
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
            tag: "policy",
            child: Text(
              "PRIVACY POLICY",
              style: textroboto18,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                40.verticalSpace,
                Text(
                  "Nullam Porta Diam Id Dolor",
                  style: txtstyleblack20Bold,
                ),
                20.verticalSpace,
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae vulputate velit. Nulla facilisi. Fusce interdum ornare arcu, quis accumsan sapien tincidunt vel. Donec tempus nibh a lectus eleifend, at aliquam quam pharetra. Aliquam blandit risus nunc, viverra porttitor ex mattis et. Maecenas accumsan felis et sem pellentesque faucibus. Aliquam facilisis facilisis est, vitae ultricies tortor auctor eget. Aenean ac metus porttitor, interdum mauris iaculis, commodo erat.",
                  style: txtstyleblack15regular,
                ),
                20.verticalSpace,
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae vulputate velit. Nulla facilisi. Fusce interdum ornare arcu, quis accumsan sapien tincidunt vel. Donec tempus nibh a lectus eleifend, at aliquam quam pharetra. Aliquam blandit risus nunc, viverra porttitor ex mattis et. Maecenas accumsan felis et sem pellentesque faucibus. Aliquam facilisis facilisis est, vitae ultricies tortor auctor eget. Aenean ac metus porttitor, interdum mauris iaculis, commodo erat.",
                  style: txtstyleblack15regular,
                ),
                20.verticalSpace,
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae vulputate velit. Nulla facilisi. Fusce interdum ornare arcu, quis accumsan sapien tincidunt vel. Donec tempus nibh a lectus eleifend, at aliquam quam pharetra. Aliquam blandit risus nunc, viverra porttitor ex mattis et. Maecenas accumsan felis et sem pellentesque faucibus. Aliquam facilisis facilisis est, vitae ultricies tortor auctor eget. Aenean ac metus porttitor, interdum mauris iaculis, commodo erat.",
                  style: txtstyleblack15regular,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}