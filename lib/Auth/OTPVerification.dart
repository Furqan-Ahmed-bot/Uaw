import 'package:_uaw/Auth/APIService/API.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Global.dart';
import '../Helpers.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class OTPVerificationScreen extends StatefulWidget {
  final email;
  OTPVerificationScreen({super.key, this.email});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  CountDownController _CountDownController = CountDownController();
  final _formKey = GlobalKey<FormState>();
  var resend;

  // TextEditingController otpController = OtpField();
  String OTPvalue = "";

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
                            "OTP Verification",
                            style: textroboto28,
                          ),
                          20.verticalSpace,
                          Text(
                            "Please enter your OTP",
                            textAlign: TextAlign.center,
                            style: textroboto16,
                          ),
                          40.verticalSpace,
                          Form(
                            key: _formKey,
                            child: OTPTextField(
                              // controller: otpController,

                              onChanged: (pin) {
                                OTPvalue = pin;
                              },
                              otpFieldStyle: OtpFieldStyle(
                                disabledBorderColor: Colors.transparent,
                                focusBorderColor: Color(0xff04366B),
                                borderColor: Color(0xff04366B),
                                enabledBorderColor: Color(0xff04366B),
                                backgroundColor: Colors.white,
                              ),
                              obscureText: false,
                              length: 6,
                              width: Get.width * 0.9,

                              fieldWidth: 55.w,
                              spaceBetween: 5.w,

                              style: TextStyle(
                                fontSize: 30.sp,
                                color: Colors.black,
                              ),
                              // textFieldAlignment: MainAxisAlignment.spaceAround,

                              fieldStyle: FieldStyle.box,

                              onCompleted: (pin) {},
                            ),
                          ),
                          // Form(
                          //   key: _formKey,
                          //   child: TextFormField(
                          //     validator: (value) {
                          //       if (value == null || value.isEmpty) {
                          //         return 'Please enter your email address';
                          //       }
                          //       return null;
                          //     },
                          //     controller: OTP,
                          //     decoration: InputDecoration(
                          //       prefixIconConstraints: BoxConstraints(minWidth: 40),
                          //       focusedBorder: UnderlineInputBorder(
                          //         borderSide: BorderSide(color: bluishshadewith40),
                          //       ),
                          //       disabledBorder: UnderlineInputBorder(
                          //         borderSide: BorderSide(color: bluishshadewith40),
                          //       ),
                          //       enabledBorder: UnderlineInputBorder(
                          //         borderSide: BorderSide(color: bluishshadewith40),
                          //       ),
                          //       border: UnderlineInputBorder(
                          //         borderSide: BorderSide(color: bluishshadewith40),
                          //       ),
                          //       prefixIcon: Image.asset(
                          //         "assets/images/Icon ionic-ios-email@3x.png",
                          //         scale: 3.5,
                          //         alignment: Alignment.centerLeft,
                          //       ),
                          //       labelText: "Jonathonm@exm.com",
                          //       labelStyle: textroboto15,
                          //     ),
                          //   ),
                          // ),

                          30.verticalSpace,
                          GestureDetector(
                            onTap: () {
                              var OTPdata = {
                                "otp": OTPvalue.toString(),
                                // "deviceType": "android",
                                // "deviceToken": AuthToken.toString(),
                              };

                              ApiService().OTPVerification(context, OTPdata);
                              // Get.to(
                              //   () => SetNewPasswordScreen(),
                              //   duration: Duration(seconds: 1),
                              //   transition: Transition.fadeIn,
                              // );
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
                                  "Continue",
                                  style: txtstylewhite20,
                                ),
                              ),
                            ),
                          ),
                          CircularCountDownTimer(
                            duration: 10,
                            initialDuration: 0,
                            controller: _CountDownController,
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.height / 8,
                            ringColor: Colors.transparent,
                            ringGradient: null,
                            fillColor: Color(0xff04366B),
                            fillGradient: null,
                            backgroundGradient: null,
                            strokeWidth: 3.0,
                            strokeCap: StrokeCap.round,
                            textStyle: TextStyle(fontSize: 12.0, color: Color(0xff04366B), fontWeight: FontWeight.bold),
                            textFormat: CountdownTextFormat.MM_SS,
                            isReverse: true,
                            isReverseAnimation: true,
                            isTimerTextShown: true,
                            autoStart: true,
                            onStart: () {
                              print('Countdown Started');
                            },
                            onComplete: () {
                              setState(() {
                                resend = 1;
                              });
                            },
                          ),
                          resend == 1
                              ? TextButton(
                                  onPressed: () {
                                    var forgotpassdata = {
                                      "email": userEmailforOTP,
                                    };
                                    ApiService().forgotPassword(context, forgotpassdata);

                                    resend = 2;
                                  },
                                  child: Center(
                                    child: Text(
                                      "Resend ",
                                      style: TextStyle(fontSize: 18.sp, color: Color(0xff04366B)),
                                    ),
                                  ))
                              : Container()
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
