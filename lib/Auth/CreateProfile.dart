import 'dart:convert';

import 'package:_uaw/Global.dart';
import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import 'APIService/API.dart';
import 'CreateAccount.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  TextEditingController dropdown = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List designationList = [];
  var selectedDesignationID;

  dynamic temp;
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

  bool location = false;
  TextEditingController controllerLatLong = TextEditingController();
  TextEditingController controllerFullName = TextEditingController();
  TextEditingController controllerPhoneNum = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
    getDesignation();
  }

  var dropdownvalue;

  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition().then((Position position) {
      setState(() {
        _currentPosition = position;

        var lat = _currentPosition!.latitude;
        var lng = _currentPosition!.longitude;
      });

      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  File? imageFile;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);

        print("Picture" + imageFile.toString());
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
                      image: imageFile == null
                          ? DecorationImage(
                              image: AssetImage("assets/images/Group 1433@3x.png"),
                            )
                          : DecorationImage(
                              image: FileImage(imageFile!),
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                100.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.r),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == '') {
                            return 'please enter your Full Name';
                          } else {
                            return null;
                          }
                        },
                        controller: controllerFullName,
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
                        validator: (value) {
                          if (value == '') {
                            return 'please enter your Contact Number';
                          } else {
                            return null;
                          }
                        },
                        controller: controllerPhoneNum,
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
                        enabled: false,
                        controller: controllerLatLong,
                        decoration: InputDecoration(
                          hintMaxLines: 2,
                          // suffixIconConstraints: BoxConstraints(maxWidth: 35),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: _getCurrentPosition,
                          ),
                          filled: true,
                          fillColor: white,
                          prefixIconConstraints: BoxConstraints(minWidth: 50),
                          prefixIcon: Image.asset(
                            "assets/images/Group 1313@3x.png",
                            scale: 3.5,
                          ),
                          hintText: "${currentAddress ?? ""}",
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
                        validator: (value) {
                          if (value == null) {
                            return 'please select a Designation';
                          } else {
                            return null;
                          }
                        },
                        alignment: Alignment.center,
                        isDense: true,
                        icon: Image.asset(
                          "assets/images/Icon ionic-ios-arrow-down@3x.png",
                          scale: 2.5,
                          alignment: Alignment.topLeft,
                        ),
                        decoration: InputDecoration(
                          hintText: "Designation",
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
                        items: designationList.map((item) {
                          return DropdownMenuItem(
                            child: new Text(
                              item.toString(),
                              style: medium16blackwopacity,
                            ),
                            value: item.toString(),
                          );
                        }).toList(),
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
                      ),

                      // DropdownButtonFormField(
                      //   alignment: Alignment.center,
                      //   isDense: true,
                      //   icon: Image.asset(
                      //     "assets/images/Icon ionic-ios-arrow-down@3x.png",
                      //     scale: 2.5,
                      //     alignment: Alignment.topLeft,
                      //   ),
                      //   decoration: InputDecoration(
                      //     hintText: "Designation",
                      //     hintStyle: medium18blackwopacity,
                      //     prefixIconConstraints: BoxConstraints(minWidth: 25),
                      //     prefixIcon: Image.asset(
                      //       "assets/images/Group 1313@3x.png",
                      //       color: transparentcolor,
                      //       scale: 3.5,
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10.r),
                      //       borderSide: BorderSide(
                      //         color: transparentcolor,
                      //         width: 1.w,
                      //       ),
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10.r),
                      //       borderSide: BorderSide(
                      //         color: transparentcolor,
                      //         width: 1.w,
                      //       ),
                      //     ),
                      //     filled: true,
                      //     fillColor: white,
                      //   ),
                      //   dropdownColor: white,
                      //   value: dropdownvalue,
                      //   onChanged: (newValue) {
                      //     setState(() {
                      //       dropdownvalue = newValue;
                      //     });
                      //   },
                      //   items: designationList.map((item) {
                      //     return DropdownMenuItem(
                      //       child: new Text(
                      //         item.toString(),
                      //         style: medium16blackwopacity,
                      //       ),
                      //       value: item.toString(),
                      //     );
                      //   }).toList(),
                      // ),

                      30.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          var createProfiledata = {
                            "name": controllerFullName.text,
                            "lat": _currentPosition!.latitude,
                            "long": _currentPosition!.longitude,
                            "phone": controllerPhoneNum.text,
                            "email": uniqieemail.toString(),
                            "DesignationID": selectedDesignationID.toString(),
                          };
                          if (imageFile != null) {
                            print(createProfiledata);
                            if (_formKey.currentState!.validate()) {
                              Get.to(
                                  () => CreateAccountScreen(
                                      name: controllerFullName.text,
                                      lat: _currentPosition!.latitude,
                                      long: _currentPosition!.longitude,
                                      phone: controllerPhoneNum.text,
                                      email: uniqieemail.toString(),
                                      designationID: selectedDesignationID.toString(),
                                      imagepath: imageFile!.path),
                                  duration: Duration(seconds: 1),
                                  transition: Transition.fadeIn);
                            }
                          } else {
                            Get.snackbar("Error", "Please upload your image");
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
          ),
        ));
  }
}
