import 'dart:convert';

import 'package:_uaw/Auth/APIService/API.dart';
import 'package:_uaw/Controllers/usercontroller.dart';
import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../Global.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _editable = false;
  initState() {
    super.initState();

    getDesignation();
  }

  dynamic temp;
  List designationList = [];
  var selectedDesignationID;
  var dropdownvalue;

  Future getDesignation() async {
    final uri = Uri.parse("${apiGlobal}/designation");

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      temp = jsonData['data'];

      for (var i = 0; i < temp.length; i++) {
        designationList.add(temp[i]['title']);
      }
      print('designationList ${designationList}');

      print(temp);
    }
  }

  dynamic UserProfileImage;
  List<String> _locations = ['Designation-1', 'Designation-2', 'Designation-3', 'Designation-4'];
  final UserDetails = Get.put(UserController());
  var _propertytype;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      UserProfileImage = pickedFile;
      if (pickedFile != null) {
      } else {
        print('No image selected.');
      }
    });
  }

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
                    decoration: UserProfileImage == null
                        ? BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 5.w,
                              color: Color(0xff00000026),
                            ),
                            image: DecorationImage(
                              image: NetworkImage('https://uaw-api.thesuitchstaging.com:3090/${UserController.user.data!.image!.file.toString()}'),
                              fit: BoxFit.fill,
                            ),
                          )
                        : BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 5.w,
                              color: Color(0xff00000026),
                            ),
                            image: DecorationImage(
                              image: FileImage(
                                File(UserProfileImage!.path),
                              ),
                              fit: BoxFit.fill,
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
            'EDIT PROFILE',
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
              // Container(
              //   width: 1.sw,
              //   height: 180.h,
              //   decoration: BoxDecoration(
              //     gradient: SweepGradient(
              //       colors: [
              //         whitecolor,
              //         bluishshade,
              //       ],
              //       center: Alignment.bottomLeft,
              //     ),
              //   ),
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(
              //       horizontal: 20.r,
              //     ),
              //     child: Row(
              //       children: [
              //         GestureDetector(
              //           onTap: () {
              //             Get.back();
              //           },
              //           child: Container(
              //             width: 50.w,
              //             height: 50.h,
              //             decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               gradient: LinearGradient(
              //                 begin: Alignment.bottomCenter,
              //                 end: Alignment.topCenter,
              //                 colors: [
              //                   greycolor,
              //                   whitecolor,
              //                 ],
              //               ),
              //             ),
              //             child: Icon(
              //               Icons.arrow_back,
              //               color: blackcolor,
              //               size: 30,
              //             ),
              //           ),
              //         ),
              //         85.horizontalSpace,
              //         Text(
              //           "EDIT PROFILE",
              //           style: txtstylewhite18,
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // Stack(
              //   clipBehavior: Clip.none,
              //   alignment: Alignment.center,
              //   children: [
              //     Container(
              //       width: 1.sw,
              //     ),
              //     Positioned(
              //       top: -40,
              //       child: Container(
              //         width: 140.w,
              //         height: 140.h,
              //         decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           border: Border.all(
              //             width: 5.w,
              //             color: Color(0xff00000026),
              //           ),
              //           image: DecorationImage(
              //             image: AssetImage("assets/images/Group 1443@3x.png"),
              //           ),
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           crossAxisAlignment: CrossAxisAlignment.end,
              //           children: [
              //             Container(
              //               width: 40.w,
              //               height: 40.h,
              //               decoration: BoxDecoration(
              //                 shape: BoxShape.circle,
              //                 color: bluishshade,
              //               ),
              //               child: Icon(
              //                 Icons.camera_alt,
              //                 color: whitecolor,
              //                 size: 20,
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //     )
              //   ],
              // ),

              80.verticalSpace,
              Text(
                UserController.user.data!.name.toString(),
                style: textroboto20,
              ),
              5.verticalSpace,
              Text(
                UserController.user.data!.email.toString(),
                style: txtstyleblack14WO,
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Full Name",
                      style: txtstyleblack14WO,
                    ),
                    5.verticalSpace,
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        prefixIconConstraints: BoxConstraints(minWidth: 50),
                        prefixIcon: Image.asset(
                          "assets/images/Icon feather-user@3x3.png",
                          scale: 3.5,
                        ),
                        hintText: UserController.user.data!.name.toString(),
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
                    Text(
                      "Email",
                      style: txtstyleblack14WO,
                    ),
                    5.verticalSpace,
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        prefixIconConstraints: BoxConstraints(minWidth: 50),
                        prefixIcon: Image.asset(
                          "assets/images/Icon zocial-email@3x.png",
                          scale: 3.5,
                          color: black,
                        ),
                        hintText: UserController.user.data!.email.toString(),
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
                    Text(
                      "Password",
                      style: txtstyleblack14WO,
                    ),
                    5.verticalSpace,
                    TextFormField(
                      enabled: _editable,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        prefixIconConstraints: BoxConstraints(minWidth: 50),
                        prefixIcon: Image.asset(
                          "assets/images/Icon ionic-ios-lock@3x.png",
                          scale: 3.5,
                          color: black,
                        ),
                        hintText: "****",
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
                    10.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _editable = !_editable;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Change Password",
                            style: txtstyleblack14WO,
                          )
                        ],
                      ),
                    ),
                    15.verticalSpace,
                    Text(
                      "Phone Number",
                      style: txtstyleblack14WO,
                    ),
                    5.verticalSpace,
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        prefixIconConstraints: BoxConstraints(minWidth: 50),
                        prefixIcon: Image.asset(
                          "assets/images/Icon feather-phone-call@3x.png",
                          scale: 3.5,
                          color: black,
                        ),
                        hintText: UserController.user.data!.phone.toString(),
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
                    Text(
                      "Location",
                      style: txtstyleblack14WO,
                    ),
                    5.verticalSpace,
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        prefixIconConstraints: BoxConstraints(minWidth: 50),
                        prefixIcon: Image.asset(
                          "assets/images/Group 1313@3x.png",
                          scale: 3.5,
                        ),
                        hintText: currentAddress,
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
                      value: dropdownvalue,
                      alignment: Alignment.center,
                      isDense: true,
                      icon: Image.asset(
                        "assets/images/Icon ionic-ios-arrow-down@3x.png",
                        scale: 2.5,
                        alignment: Alignment.topLeft,
                      ),
                      decoration: InputDecoration(
                        hintText: UserController.user.data!.designation!.title.toString(),
                        hintStyle: medium18blackwopacity,
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
                      onChanged: (newValue) {
                        setState(() {
                          dropdownvalue = newValue;
                          temp.forEach((element) {
                            if (newValue == element["title"]) {
                              selectedDesignationID = element["_id"];
                            }
                          });
                        });
                      },
                      items: designationList.map((item) {
                        return DropdownMenuItem(
                          child: new Text(
                            item.toString(),
                            style: medium16blackwopacity,
                          ),
                          value: item.toString(),
                        );
                      }).toList(),
                    ),
                    30.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        Get.back();
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
                            "Save",
                            style: txtstylewhite20,
                          ),
                        ),
                      ),
                    ),
                    50.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
