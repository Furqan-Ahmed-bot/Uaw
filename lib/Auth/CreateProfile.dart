import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'CreateAccount.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  List<String> _locations = ['Designation-1', 'Designation-2', 'Designation-3', 'Designation-4'];
  var _propertytype;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whitish,
        appBar: AppBar(
          leadingWidth: 80.w,
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      // bottomLeft: Radius.circular(25.r),
                      // bottomRight: Radius.circular(25.r),
                      ),
                  gradient: SweepGradient(
                    colors: [
                      whitecolor,
                      bluishshade,
                    ],
                    center: Alignment.bottomLeft,
                  ),
                ),
              ),
              Positioned(
                top: 100,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    getImage();
                  },
                  child: Container(
                    width: 140.w,
                    height: 140.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 5.w,
                        color: Color(0xff00000026),
                      ),
                      image: DecorationImage(
                        image: AssetImage("assets/images/Group 1433@3x.png"),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: bluishshade,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: whitecolor,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.r),
              child: Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      greycolor,
                      whitecolor,
                    ],
                  ),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: blackcolor,
                  size: 30,
                ),
              ),
            ),
          ),
          title: Text(
            'CREATE PROFILE',
            style: txtstylewhite18,
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.pink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
        ),
       
       
        body: SingleChildScrollView(
          child: Column(
            children: [
              100.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        prefixIconConstraints: BoxConstraints(minWidth: 50),
                        prefixIcon: Image.asset(
                          "assets/images/Icon feather-user@3x3.png",
                          scale: 3.5,
                        ),
                        hintText: "Full Name",
                        hintStyle: medium18blackwopacity,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: transparentcolor,
                            width: 1.w,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: transparentcolor,
                            width: 1.w,
                          ),
                        ),
                      ),
                      style: medium18blackwopacity,
                    ),
                    15.verticalSpace,
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        prefixIconConstraints: BoxConstraints(minWidth: 50),
                        prefixIcon: Image.asset(
                          "assets/images/Icon feather-phone-call@3x.png",
                          scale: 3.5,
                        ),
                        hintText: "Phone Number",
                        hintStyle: medium18blackwopacity,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: transparentcolor,
                            width: 1.w,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: transparentcolor,
                            width: 1.w,
                          ),
                        ),
                      ),
                      style: medium18blackwopacity,
                    ),
                    15.verticalSpace,
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        prefixIconConstraints: BoxConstraints(minWidth: 50),
                        prefixIcon: Image.asset(
                          "assets/images/Group 1313@3x.png",
                          scale: 3.5,
                        ),
                        hintText: "Location",
                        hintStyle: medium18blackwopacity,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: transparentcolor,
                            width: 1.w,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: transparentcolor,
                            width: 1.w,
                          ),
                        ),
                      ),
                      style: medium18blackwopacity,
                    ),
                    15.verticalSpace,
                    DropdownButtonFormField(
                      icon: Image.asset(
                        "assets/images/Icon ionic-ios-arrow-down@3x.png",
                        scale: 2.5,
                        alignment: Alignment.topLeft,
                      ),
                      decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 25),
                        prefixIcon: Image.asset(
                          "assets/images/Group 1313@3x.png",
                          color: transparentcolor,
                          scale: 3.5,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: transparentcolor,
                            width: 1.w,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: transparentcolor,
                            width: 1.w,
                          ),
                        ),
                        filled: true,
                        fillColor: white,
                      ),
                      dropdownColor: white,
                      value: _propertytype,
                      onChanged: (newValue) {
                        setState(() {
                          _propertytype = newValue!;
                        });
                      },
                      items: _locations.map((location) {
                        return DropdownMenuItem(
                          child: new Text(
                            location,
                            style: medium18blackwopacity,
                          ),
                          value: location,
                        );
                      }).toList(),
                    ),
                    30.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        Get.to(() => CreateAccountScreen(), duration: Duration(seconds: 1), transition: Transition.fadeIn);
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
                            "Next",
                            style: txtstylewhite20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
