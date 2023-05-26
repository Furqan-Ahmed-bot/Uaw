import 'package:_uaw/Auth/APIService/API.dart';
import 'package:_uaw/Auth/SetNewPassword.dart';
import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Global.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController forgotPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
          child: Container(
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
                90.verticalSpace,
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
                            "Forgot Password",
                            style: textroboto28,
                          ),
                          20.verticalSpace,
                          Text(
                            "Please enter your email to reset password",
                            textAlign: TextAlign.center,
                            style: textroboto16,
                          ),
                          40.verticalSpace,
                          Form(
                            key: _formKey,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email address';
                                }
                                return null;
                              },
                              controller: forgotPassword,
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
                          ),
                          30.verticalSpace,
                          GestureDetector(
                            onTap: () {
                              userEmailforOTP = forgotPassword.text;
                              var forgotpassdata = {
                                "email": forgotPassword.text,
                               
                              };
                              if (_formKey.currentState!.validate()) {
                                ApiService().forgotPassword(context, forgotpassdata);

                             
                              } else {
                                Get.snackbar("Error", "PLease enter your email address");
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
                                  "Reset Password",
                                  style: txtstylewhite20,
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
        ),
      ),
    );
 
 
  }
}
