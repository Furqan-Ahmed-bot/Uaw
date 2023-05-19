import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'APIService/API.dart';
import 'TermsOfServices.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController uniqueId = TextEditingController();
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
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        70.verticalSpace,
                        Text(
                          "Unique ID",
                          style: textroboto28,
                        ),
                        20.verticalSpace,
                        Text(
                          "Please enter your unique ID provided by the admin",
                          textAlign: TextAlign.center,
                          style: textroboto16,
                        ),
                        40.verticalSpace,
                        TextFormField(
                          controller: uniqueId,
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
                        GestureDetector(
                          onTap: () {
                            var data = {
                              "email": uniqueId.text,
                            };
                            print(data);
                            if (uniqueId == null) {
                              Get.snackbar("Error", "Please enter UniqueID");
                            } else {
                              ApiService().uniqueID(context, data);
                            }
                          },
                          child: Hero(
                            transitionOnUserGestures: true,
                            tag: 'myTag-4',
                            child: Material(
                              type: MaterialType.transparency,
                              child: Container(
                                width: 345.w,
                                height: 55.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: bluishshade,
                                ),
                                child: Center(
                                  child: Text(
                                    "Submit",
                                    style: txtstylewhite20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
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
