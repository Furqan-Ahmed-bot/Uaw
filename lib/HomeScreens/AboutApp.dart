import 'package:_uaw/Auth/APIService/API.dart';
import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AboutAppScreen extends StatefulWidget {
  final String value;
  const AboutAppScreen({super.key, required this.value});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> with SingleTickerProviderStateMixin {
  late final AboutApp;
  bool _isLoading = false;

  getaboutApp() async {
    AboutApp = await ApiService().getAbout();
    print("privacy ${AboutApp}");
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getaboutApp();
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
            tag: "aboutApp",
            child: Text(
              "ABOUT APP",
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
                        AboutApp["data"][0]["contentType"].toString(),
                        style: txtstyleblack20Bold,
                      ),
                      20.verticalSpace,
                      Text(
                        AboutApp["data"][0]["title"].toString(),
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
