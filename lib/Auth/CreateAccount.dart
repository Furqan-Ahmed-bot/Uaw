import 'dart:ui';

import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/NavBar.dart';
import 'package:_uaw/HomeScreens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Controller.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final bottomcontroller = Get.put(BottomController());
  bool _obscureText = false;
  bool _obscureText2 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: SweepGradient(
          colors: [
            whitecolor,
            bluishshade,
          ],
          center: Alignment.centerLeft,
        ),
        image: DecorationImage(
          image: AssetImage("assets/images/Mask Group 3@3x.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: transparentcolor,
          appBar: AppBar(
            leadingWidth: 80,
            backgroundColor: transparentcolor,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Center(
                child: Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          greycolor,
                          whitecolor,
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: black,
                    )),
              ),
            ),
          ),
          body: ListView(
            children: [
              50.verticalSpace,
              Center(
                child: Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Group 141@3x.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              80.verticalSpace,
              Container(
                width: 1.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.r),
                    topRight: Radius.circular(50.r),
                  ),
                  color: whitecolor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.r),
                  child: Column(
                    children: [
                      70.verticalSpace,
                      Center(
                        child: Text(
                          "Create Account",
                          style: textroboto28,
                        ),
                      ),
                      50.verticalSpace,
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIconConstraints: BoxConstraints(minWidth: 50),
                          prefixIcon: Container(
                            width: 50.w,
                            child: Image.asset(
                              "assets/images/Icon ionic-ios-mail@3x.png",
                              color: bluishshade,
                              scale: 3,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          labelText: "Jonathonm@exm.com",
                          labelStyle: textroboto15,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: bluishshadewith40,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: bluishshadewith40,
                            ),
                          ),
                        ),
                        style: textroboto15,
                      ),
                      30.verticalSpace,
                      TextFormField(
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          prefixIconConstraints: BoxConstraints(minWidth: 50),
                          prefixIcon: Container(
                            width: 50.w,
                            child: Image.asset(
                              "assets/images/Icon ionic-ios-lock@3x.png",
                              color: bluishshade,
                              scale: 3,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          labelText: "Password",
                          labelStyle: textroboto15,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: bluishshadewith40,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: bluishshadewith40,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                            ),
                            color: bluishshade,
                            onPressed: (() {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            }),
                          ),
                        ),
                        style: textroboto15,
                      ),
                      30.verticalSpace,
                      TextFormField(
                        obscureText: _obscureText2,
                        decoration: InputDecoration(
                          prefixIconConstraints: BoxConstraints(minWidth: 50),
                          prefixIcon: Container(
                            width: 50.w,
                            child: Image.asset(
                              "assets/images/Icon ionic-ios-lock@3x.png",
                              color: bluishshade,
                              scale: 3,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          labelText: "*******",
                          labelStyle: textroboto15,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: bluishshadewith40,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: bluishshadewith40,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText2 ? Icons.visibility_off : Icons.visibility,
                            ),
                            color: bluishshade,
                            onPressed: (() {
                              setState(() {
                                _obscureText2 = !_obscureText2;
                              });
                            }),
                          ),
                        ),
                        style: textroboto15,
                      ),
                      30.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          bottomcontroller.navBarChange(0);
                          Get.to(() => NavBarScreen(), duration: Duration(seconds: 1), transition: Transition.fadeIn);
                        },
                        child: Container(
                          width: 1.sw,
                          height: 55.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: bluishshade,
                          ),
                          child: Center(
                            child: Text(
                              "Signup",
                              style: txtstylewhite20,
                            ),
                          ),
                        ),
                      ),
                      200.verticalSpace,
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
