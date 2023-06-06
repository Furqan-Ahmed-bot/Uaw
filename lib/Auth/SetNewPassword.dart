import 'package:_uaw/Auth/APIService/API.dart';
import 'package:_uaw/Auth/Login.dart';
import 'package:_uaw/Global.dart';
import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _validatepassword = false;
  bool _validateconfirmpassword = false;
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
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
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
                    // height: 0.5.sh,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.r),
                        topRight: Radius.circular(50.r),
                      ),
                      color: whitecolor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.r),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            70.verticalSpace,
                            Text(
                              "New Password",
                              style: textroboto28,
                            ),
                            20.verticalSpace,
                            Text(
                              "Please enter your new password",
                              textAlign: TextAlign.center,
                              style: textroboto16,
                            ),
                            50.verticalSpace,
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
                              controller: newPassword,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                // errorText: _validatepassword ? "value can't be null" : null,
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
                                // errorText: _validateconfirmpassword ? "value can't be empty" : null,
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
                                var newPasswordData = {
                                  "password": newPassword.text,
                                };
                                // setState(() {
                                //   newPassword.text.isEmpty ? _validatepassword = true : _validatepassword = false;
                                // });
                                if (newPassword.text != confirmPassword.text) {
                                  Get.snackbar("Error", "Password must be same");
                                } else if (_formKey.currentState!.validate()) {
                                  // if (password.text.isEmpty) {
                                  //   Get.snackbar("Error", "Password field cant be null");
                                  // } else if (password.text != confirmPassword.text) {
                                  //   Get.snackbar("Error", "Password and Confirm Password doesnot match");
                                  // } else {
                                  ApiService().ResetPassword(context, newPasswordData);
                                }

                                // if (newPassword.text.isEmpty) {
                                //   Get.snackbar("Error", "Password field cant be null");
                                // } else if (newPassword.text != confirmPassword.text) {
                                //   Get.snackbar("Error", "Password and Confirm Password doesnot match");
                                // } else {
                                //   ApiService().ResetPassword(context, newPasswordData);
                                // }
                                // Get.to(() => LoginScreen(), duration: Duration(seconds: 1), transition: Transition.fadeIn);
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
                                    "Submit",
                                    style: txtstylewhite20,
                                  ),
                                ),
                              ),
                            ),
                            150.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
