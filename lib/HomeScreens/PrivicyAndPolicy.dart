import 'package:_uaw/Auth/APIService/API.dart';
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

class _PrivicyAndPolicyScreenState extends State<PrivicyAndPolicyScreen> with SingleTickerProviderStateMixin {
  late final PrivacyPolicy;
  bool _isLoading = false;
  getPrivacyPolicy() async {
    PrivacyPolicy = await ApiService().GetPrivacy(context);
    print("privacy ${PrivacyPolicy}");
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getPrivacyPolicy();
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
            child: _isLoading == false
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      40.verticalSpace,
                      Text(
                        PrivacyPolicy["data"][0]["contentType"].toString(),
                        style: txtstyleblack20Bold,
                      ),
                      20.verticalSpace,
                      Text(
                        PrivacyPolicy["data"][0]["title"].toString(),
                        style: txtstyleblack15regular,
                      ),
                      50.verticalSpace,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
