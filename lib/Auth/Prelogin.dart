import 'package:_uaw/Auth/Login.dart';
import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PreloginScreen extends StatefulWidget {
  const PreloginScreen({super.key});

  @override
  State<PreloginScreen> createState() => _PreloginScreenState();
}

class _PreloginScreenState extends State<PreloginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: transparentcolor,
      body: SingleChildScrollView(
        child: Container(
          width: 1.sw,
          height: 1.sh,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/Mask Group 3@3x.png"), fit: BoxFit.fill),
          ),
          child: Column(
            children: [
              120.verticalSpace,
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
              70.verticalSpace,
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
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        60.verticalSpace,
                        Text(
                          "Pre Login",
                          style: textroboto28,
                        ),
                        50.verticalSpace,
                        GestureDetector(
                          onTap: () {
                            Get.to(() => LoginScreen());
                          },
                          child: PreloginWidget(
                            containercolor2: Color(0xffFD6939),
                            containercolor: Color(0xffFDAA4A),
                            containertextcolor: whitecolor,
                            iconimage: "assets/images/Icon zocial-email@3x.png",
                            containertext: "Login with Email",
                          ),
                        ),
                        15.verticalSpace,
                        PreloginWidget(
                          containercolor2: Color(0xff5C82E8),
                          containercolor: Color(0xff3A559F),
                          containertextcolor: whitecolor,
                          iconimage: "assets/images/Icon awesome-facebook-f@3x.png",
                          containertext: "Login with Facebook",
                        ),
                        15.verticalSpace,
                        PreloginWidget(
                          containercolor2: Color(0xffFF5C4D),
                          containercolor: Color(0xffCB3E32),
                          containertextcolor: whitecolor,
                          iconimage: "assets/images/Icon simple-google@3x.png",
                          containertext: "Login with Google",
                        ),
                        15.verticalSpace,
                        PreloginWidget(
                          containercolor2: Color(0xff000000),
                          containercolor: Color(0xff000000),
                          containertextcolor: whitecolor,
                          iconimage: "assets/images/Icon awesome-apple@3x.png",
                          containertext: "Login with Apple",
                        ),
                        Spacer(),
                        Center(
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
                        20.verticalSpace
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PreloginWidget extends StatelessWidget {
  String iconimage;
  var containertext;
  var containercolor;
  var containercolor2;
  var containertextcolor;
  PreloginWidget({
    required this.iconimage,
    this.containertext,
    required this.containercolor,
    required this.containercolor2,
    required this.containertextcolor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 368.w,
      height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            containercolor2,
            containercolor,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconimage,
            scale: 3.5,
          ),
          20.horizontalSpace,
          Container(
            child: Text(
              containertext,
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: containertextcolor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
