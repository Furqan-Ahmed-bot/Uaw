import 'dart:ui';

import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/NavBar.dart';
import 'package:_uaw/HomeScreens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Controller.dart';
import '../Global.dart';
import 'APIService/API.dart';

class CreateAccountScreen extends StatefulWidget {
  final name;
 final location;
  // final lat;
  // final long;
  final phone;
  final email;
  final designationID;
  final imagepath;

  CreateAccountScreen({super.key, this.name, this.location, this.phone, this.email, this.designationID, this.imagepath});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _validatepassword = false;
  bool _validateconfirmpassword = false;

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final bottomcontroller = Get.put(BottomController());

  void initState() {
    super.initState();
    print(widget.name);
  }

  bool _obscureText = true;
  bool _obscureText2 = true;
  @override
  void dispose() {
    password.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    widget.imagepath;
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
          body: Form(
            key: _formKey,
            child: ListView(
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
                          enabled: false,
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
                            labelText: widget.email,
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
                          validator: (value) {
                            if (value == '') {
                              return 'please enter new password';
                            } else if (!(value!.length >= 8)) {
                              return 'password should be greater than 8 characters';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            _formKey.currentState!.validate();
                          },
                          controller: password,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            prefixIconConstraints: BoxConstraints(minWidth: 50),
                            // errorText: _validatepassword ? "value can't be null" : null,
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
                          validator: (value) {
                            if (value == '') {
                              return 'please confirm password';
                            } else if (!(value!.length >= 8)) {
                              return 'password should be same';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            _formKey.currentState!.validate();
                          },
                          controller: confirmPassword,
                          obscureText: _obscureText2,
                          decoration: InputDecoration(
                            prefixIconConstraints: BoxConstraints(minWidth: 50),
                            // errorText: _validateconfirmpassword ? "value can't be empty" : null,
                            prefixIcon: Container(
                              width: 50.w,
                              child: Image.asset(
                                "assets/images/Icon ionic-ios-lock@3x.png",
                                color: bluishshade,
                                scale: 3,
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            labelText: "Confirm Password",
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
                          onTap: () async {
                            var completeProfile = {
                             
                              "phone": widget.phone,
                              "location":widget.location,
                              // "long": widget.long.toString(),
                              // "lat": widget.lat.toString(),
                              "password": password.text,
                              "name": widget.name,
                              "email": widget.email,
                              "designation": widget.designationID.toString(),
                              "deviceType": "android",
                                "deviceToken": "$deviceToken",
                            };

                            // setState(() {
                            //   password.text.isEmpty ? _validatepassword = true : _validatepassword = false;
                            // });

                            if (password.text != confirmPassword.text) {
                              Get.snackbar("Error", "Password must be same");
                            } else if (_formKey.currentState!.validate()) {
                              // if (password.text.isEmpty) {
                              //   Get.snackbar("Error", "Password field cant be null");
                              // } else if (password.text != confirmPassword.text) {
                              //   Get.snackbar("Error", "Password and Confirm Password doesnot match");
                              // } else {
                              ApiService().CreateProfile(context, completeProfile, widget.imagepath);
                            }
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
                        100.verticalSpace,
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
