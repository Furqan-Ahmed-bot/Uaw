import 'dart:async';
import 'dart:convert';

import 'package:_uaw/Auth/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Controller.dart';
import 'Controllers/usercontroller.dart';
import 'Global.dart';
import 'package:_uaw/Models/usermodel.dart';

import 'HomeScreens/NavBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final bottomcontroller = Get.put(BottomController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; // Change here
    // _firebaseMessaging.getToken().then((token) {
    //   deviceToken = token!;
    //   print('DEVICE TOKEN: $deviceToken');
    // });
  }

  startTimer() async {
    Future.delayed(Duration(seconds: 3), () async {
      try {
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        UserController usercontroller = Get.put(UserController());

        String? model = _prefs.getString("model");
        if (model != null) {
          final modelList = json.decode(model);
          usercontroller.User(userModel.fromJson(modelList));
          usercontroller.data;
          AuthToken = _prefs.getString("globaltoken")!;
          userid = _prefs.get("userId");
          bottomcontroller.navBarChange(0);
          Get.to(() => const NavBarScreen(), duration: const Duration(seconds: 1), transition: Transition.fadeIn);
        } else {
          Get.to(() => LoginScreen());
        }
      } catch (e) {
        print(e);
        Get.to(() => LoginScreen());
      }
    });
  }

  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/Mask Group 3@3x.png"), fit: BoxFit.fill),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/Group 144@3x.png"),
        ],
      ),
    );
  }
}
