import 'dart:convert';
import 'dart:math';

import 'package:_uaw/Auth/APIService/API.dart';
import 'package:_uaw/Controllers/usercontroller.dart';
import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
  final _formKey = GlobalKey<FormState>();
  TextEditingController locationController = TextEditingController();
  bool forloaction = false;

  TextEditingController fullnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  late double latitude;
  late double longitude;

  final _focusNode = FocusNode();
  bool _editable = false;
  initState() {
    super.initState();
    _getCurrentPosition();

    getDesignation();
    fullnameController.text = UserController.user.data!.name.toString();
    // passwordController.text = UserController.user.data!.password.toString();
    phonenumberController.text = UserController.user.data!.phone.toString();
    locationController.text = UserController.user.data!.location.toString();
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

  // Future<String> getAddressFromLatLng() async {
  //   longitude = UserController.user.data!.location!.coordinates![0];
  //   latitude = UserController.user.data!.location!.coordinates![1];
  //   final placemarks = await placemarkFromCoordinates(latitude, longitude);
  //   if (placemarks != null && placemarks.isNotEmpty) {
  //     final placemark = placemarks[0];
  //     completeAddress =
  //         '${placemark.street},${placemark.subLocality},${placemark.locality}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
  //     return '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
  //   }
  //   return "Unable to get address";
  // }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition().then((Position position) {
      setState(() {
        _currentPosition = position;

        latitude = _currentPosition!.latitude;
        longitude = _currentPosition!.longitude;
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

  dynamic temp;
  List designationList = [];
  var selectedDesignationID;

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                  top: 120,
                  child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        getImage();
                      },
                      child: UserProfileImage != null
                          ? CircleAvatar(
                              radius: 70.r,
                              // backgroundColor: Colors.transparent,
                              backgroundImage: FileImage(
                                File(UserProfileImage!.path),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 90),
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
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: 60.r,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  NetworkImage('https://uaw-api.thesuitchstaging.com:3090/${UserController.user.data!.image!.file.toString()}'),
                              child: Padding(
                                padding: EdgeInsets.only(top: 90),
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
                                    ),
                                  ],
                                ),
                              ),
                            )
                      // Container(
                      //   width: 140.w,
                      //   height: 140.h,
                      //   decoration: UserProfileImage == null
                      //       ? BoxDecoration(
                      //           shape: BoxShape.circle,
                      //           border: Border.all(
                      //             width: 5.w,
                      //             color: Color(0xff00000026),
                      //           ),
                      //           image: DecorationImage(
                      //             image: NetworkImage('https://uaw-api.thesuitchstaging.com:3090/${UserController.user.data!.image!.file.toString()}'),
                      //             fit: BoxFit.fitWidth,
                      //           ),
                      //         )
                      //       : BoxDecoration(
                      //           shape: BoxShape.circle,
                      //           border: Border.all(
                      //             width: 5.w,
                      //             color: Color(0xff00000026),
                      //           ),
                      //           image: DecorationImage(
                      //             image: FileImage(
                      //               File(UserProfileImage!.path),
                      //             ),
                      //             fit: BoxFit.fitWidth,
                      //           ),
                      //         ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     crossAxisAlignment: CrossAxisAlignment.end,
                      //     children: [
                      //       Container(
                      //         width: 40.w,
                      //         height: 40.h,
                      //         decoration: BoxDecoration(
                      //           shape: BoxShape.circle,
                      //           color: bluishshade,
                      //         ),
                      //         child: Icon(
                      //           Icons.camera_alt,
                      //           color: whitecolor,
                      //           size: 20,
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),

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
            child: Form(
              key: _formKey,
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
                          controller: fullnameController,
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
                          enabled: false,
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
                            if (_formKey.currentState!.validate()) {}
                          },
                          controller: passwordController,
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
                            hintText: "********",
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
                            if (_formKey.currentState!.validate()) {}
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
                          controller: phonenumberController,
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
                          minLines: 1,
                          maxLines: null,
                          controller: locationController,
                          // onChanged: (value) async {
                          //   final List<double>? latlng = await getLatLong(value);
                          //   if (latlng != null) {
                          //     latitude = latlng[0];
                          //     longitude = latlng[1];
                          //     print('Latitude: $latitude, Longitude: $longitude');
                          //   } else {
                          //     print('Invalid address');
                          //   }
                          // },
                          decoration: InputDecoration(
                            hintMaxLines: 2,
                            // suffixIconConstraints: BoxConstraints(maxWidth: 35),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                dynamic newAddress;
                                setState(() {
                                  forloaction = !forloaction;
                                  if (completeAddress != null) {
                                    setState(() {
                                      completeAddress = newAddress.toString();
                                    });
                                  }
                                });
                                _getCurrentPosition();
                                locationController.text = currentAddress.toString();
                                // if (completeAddress != null) {
                                //   completeAddress = newAddress.toString();
                                // }
                              },
                              child: (Icon(
                                Icons.search,
                              )),
                            ),
                            filled: true,
                            fillColor: white,
                            prefixIconConstraints: BoxConstraints(minWidth: 50),
                            prefixIcon: GestureDetector(
                              child: Image.asset(
                                "assets/images/Group 1313@3x.png",
                                scale: 3.5,
                              ),
                            ),

                            hintText: forloaction == true ? currentAddress.toString() : completeAddress,
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

                        // TextFormField(
                        //   // maxLines: 2,
                        //   controller: locationController,
                        //   // onFieldSubmitted: (value) async {
                        //   //   // Get latitude and longitude
                        //   //   final String address = locationController.text.trim();
                        //   //   final List<Location> locations = await locationFromAddress(address);
                        //   //   if (locations.isNotEmpty) {
                        //   //     Location location = locations.first;
                        //   //     latitude = location.latitude;
                        //   //     longitude = location.longitude;
                        //   //     print('Latitude: $latitude, Longitude: $longitude');
                        //   //     // Do something with latitude and longitude here
                        //   //   } else {
                        //   //     print('Could not find location for address: $address');
                        //   //   }
                        //   // },
                        //   onEditingComplete: () async {
                        //     Future<String> getAddress(double latitude, double longitude) async {
                        //       final List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
                        //       if (placemarks.isNotEmpty) {
                        //         final Placemark placemark = placemarks.first;
                        //         final String address =
                        //             '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
                        //         return address;
                        //       } else {
                        //         return 'Unknown location';
                        //       }
                        //     }
                        //   },
                        //   // onEditingComplete: () async {
                        //   //   // Get latitude and longitude
                        //   //   final String address = locationController.text.trim();
                        //   //   final List<Location> locations = await locationFromAddress(address);
                        //   //   if (locations.isNotEmpty) {
                        //   //     final Location location = locations.first;
                        //   //     latitude = location.latitude;
                        //   //     longitude = location.longitude;
                        //   //     print('Latitude: $latitude, Longitude: $longitude');
                        //   //     // Do something with latitude and longitude here
                        //   //   } else {
                        //   //     print('Could not find location for address: $address');
                        //   //   }
                        //   // },

                        //   focusNode: _focusNode,

                        //   decoration: InputDecoration(
                        //     filled: true,
                        //     fillColor: white,
                        //     prefixIconConstraints: BoxConstraints(minWidth: 50),
                        //     prefixIcon: Image.asset(
                        //       "assets/images/Group 1313@3x.png",
                        //       scale: 3.5,
                        //     ),
                        //     hintText: currentAddress,
                        //     hintStyle: medium18blackwopacity,
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
                        //   ),
                        //   style: medium18blackwopacity,
                        // ),

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
                            var updateProfiledata = {
                              "name": fullnameController.text,
                              "password": passwordController.text,
                              "phone": phonenumberController.text,
                              "location": locationController.text,
                              // "lat": latitude.toString(),
                              // "long": longitude.toString(),
                              "designation": selectedDesignationID.toString(),
                              // "email": uniqieemail.toString(),
                            };
                            print(updateProfiledata.toString());
                            if (UserProfileImage != null) {
                              ApiService().UpdateProfile(context, updateProfiledata, UserProfileImage: UserProfileImage.path);
                            } else {
                              ApiService().UpdateProfile(context, updateProfiledata);
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
            ),
          )),
    );
  }

  // Future<List<double>?> getLatLong(String address) async {
  //   final List<Location> locations = await locationFromAddress(address);
  //   if (locations.isNotEmpty) {
  //     final Location location = locations.first;
  //     final List<double> latlong = [location.latitude, location.longitude];
  //     return latlong;
  //   } else {
  //     return null;
  //   }
  // }
}
