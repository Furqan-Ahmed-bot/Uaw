import 'package:_uaw/Auth/APIService/API.dart';
import 'package:_uaw/Auth/ForgotPassword.dart';
import 'package:_uaw/Controller.dart';
import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/NavBar.dart';
import 'package:_uaw/HomeScreens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controllers/usercontroller.dart';
import '../Global.dart';
import '../Welcome.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _validatepassword = false;

  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final bottomcontroller = Get.put(BottomController());

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/Mask Group 3@3x.png"), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: transparentcolor,
        appBar: AppBar(
          leadingWidth: 80,
          backgroundColor: transparentcolor,
          elevation: 0,
          leading: GestureDetector(
              // onTap: () {
              //   Get.back();
              // },
              // child: Center(
              //   child: Container(
              //       width: 50.w,
              //       height: 50.h,
              //       decoration: BoxDecoration(
              //         gradient: LinearGradient(
              //           begin: Alignment.bottomCenter,
              //           end: Alignment.topCenter,
              //           colors: [
              //             greycolor,
              //             whitecolor,
              //           ],
              //         ),
              //         shape: BoxShape.circle,
              //       ),
              //       child: Icon(
              //         Icons.arrow_back,
              //         color: black,
              //       )),
              // ),
              ),
        ),
        body: ListView(children: [
          Container(
            width: 1.sw,
            height: 1.sh,
            // decoration: BoxDecoration(
            //   image: DecorationImage(image: AssetImage("assets/images/Mask Group 3@3x.png"), fit: BoxFit.fill),
            // ),
            child: Column(
              children: [
                // 120.verticalSpace,
                Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Group 141@3x.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                80.verticalSpace,
                Expanded(
                  child: Container(
                    width: 1.sw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.r),
                        topRight: Radius.circular(50.r),
                      ),
                      color: whitecolor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          70.verticalSpace,
                          Text(
                            "Login",
                            style: textroboto28,
                          ),
                          40.verticalSpace,
                          TextFormField(
                            controller: userEmail,
                            decoration: InputDecoration(
                              prefixIconConstraints: BoxConstraints(minWidth: 40),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: bluishshadewith40),
                              ),
                              disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: bluishshadewith40),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: bluishshadewith40),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: bluishshadewith40),
                              ),
                              prefixIcon: Image.asset(
                                "assets/images/Icon ionic-ios-email@3x.png",
                                scale: 3.5,
                                alignment: Alignment.centerLeft,
                              ),
                              labelText: "Jonathonm@exm.com",
                              labelStyle: textroboto15,
                            ),
                          ),
                          30.verticalSpace,
                          TextFormField(
                            controller: userPassword,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              errorText: _validatepassword ? "Password Can't be empty" : null,
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
                          GestureDetector(
                            onTap: () {
                              var loginData = {
                                "useremail": userEmail.text,
                                "userPassword": userPassword.text,
                                "deviceType": "android",
                                "deviceToken": "$deviceToken",
                              };

                              setState(() {
                                userPassword.text.isEmpty ? _validatepassword = true : _validatepassword = false;
                              });
                              if (userPassword.text.isEmpty) {
                                Get.snackbar("Error", "Password field cant be null");
                              } else {
                                ApiService().loginAPI(context, loginData);
                              }
                            },
                            child: Container(
                              width: 345.w,
                              height: 55.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: bluishshade,
                              ),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: txtstylewhite20,
                                ),
                              ),
                            ),
                          ),
                          20.verticalSpace,
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => ForgotPasswordScreen(),
                                duration: Duration(seconds: 1),
                                transition: Transition.fadeIn,
                              );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: textroboto18,
                            ),
                          ),
                          50.verticalSpace,
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => WelcomeScreen());
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    color: Color(0xff04366B),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Signup',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                        color: Color(0xff04366B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
