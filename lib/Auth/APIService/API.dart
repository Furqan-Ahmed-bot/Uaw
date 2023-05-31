import 'dart:convert';
import 'dart:developer';

import 'package:_uaw/Auth/Login.dart';
import 'package:_uaw/Auth/OTPVerification.dart';
import 'package:_uaw/Controllers/usercontroller.dart';
import 'package:_uaw/Models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:path/path.dart' as path;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Controller.dart';
import '../../Global.dart';
import '../../HomeScreens/NavBar.dart';
import '../Prelogin.dart';
import '../SetNewPassword.dart';
import '../TermsOfServices.dart';
import 'dart:io';
import 'package:http_parser/src/media_type.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

String apiGlobal = "https://uaw-api.thesuitchstaging.com:3090/api/v1";
final bottomcontroller = Get.put(BottomController());
final usercontroller = Get.put(UserController());

class ApiService {
  logoutAPI(context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
    final uri = Uri.parse("${apiGlobal}/user/logout");
    final headers = {
      'Authorization': 'Bearer ${AuthToken}',
    };
    final body = {
      "deviceType": "android",
      "deviceToken": deviceToken,
    };
    http.Response response = await http.post(
      uri,
      headers: headers,
      body: body,
    );
    var res_data = json.decode(response.body.toString());
    if (res_data["status"] == true) {
      Get.snackbar("Message", "",
          backgroundColor: Colors.grey,
          messageText: Text(
            res_data['message'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
      Get.to(() => PreloginScreen(), duration: Duration(seconds: 1), transition: Transition.fadeIn);
    } else {
      Get.back();
      Get.snackbar("Error", "",
          backgroundColor: Colors.grey,
          messageText: Text(
            res_data['message'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
    }
  }

  uniqueID(context, data) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
    final uri = Uri.parse("${apiGlobal}/verifyuniqueid");

    final body = {
      'email': data['email'],
    };
    http.Response response = await http.post(
      uri,
      body: body,
    );
    var res_data = json.decode(response.body.toString());

    if (res_data['status'] == true) {
      uniqieemail = data['email'];
      Get.back();

      Get.to(
        () => TermsOfServices(),
        duration: Duration(seconds: 1),
        transition: Transition.fadeIn,
      );
    } else {
      Get.back();
      Get.snackbar("Error", "",
          backgroundColor: Colors.grey,
          messageText: Text(
            res_data['message'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
    }
    ;

    return res_data;
  }

  loginAPI(context, loginData) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
    final uri = Uri.parse("${apiGlobal}/login");
    final headers = {'Content-Type': 'application/json'};

    final body = {
      "email": loginData["useremail"],
      "password": loginData["userPassword"],
      "deviceType": "android",
      "deviceToken": "abc",
    };
    http.Response response = await http.post(
      uri,
      body: body,
    );
    var res_data = json.decode(response.body.toString());

    if (res_data["status"] == true) {
      usercontroller.User(userModel.fromJson(res_data));
      AuthToken = res_data["data"]["token"].toString();
      getAddressFromLatLng();
      Get.back();

      Get.snackbar("Message", "",
          backgroundColor: Colors.grey,
          messageText: Text(
            res_data['message'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
      bottomcontroller.navBarChange(0);
      Get.to(() => NavBarScreen(), duration: Duration(seconds: 1), transition: Transition.fadeIn);
    } else {
      Get.back();
      Get.snackbar("Error", "",
          backgroundColor: Colors.grey,
          messageText: Text(
            res_data['message'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
    }
  }

  forgotPassword(context, forgotpassdata) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
    final uri = Uri.parse("${apiGlobal}/forgetpassword");
    final headers = {'Content-Type': 'application/json'};

    final body = {
      "email": forgotpassdata["email"],
    };
    http.Response response = await http.post(uri, body: body);

    var res_data = json.decode(response.body.toString());
    if (res_data["status"] == true) {
      AuthToken = res_data["data"]["token"].toString();
      Get.back();

      Get.snackbar("Message", "",
          backgroundColor: Colors.grey,
          messageText: Text(
            res_data['message'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
      Get.to(
        () => OTPVerificationScreen(),
        duration: Duration(seconds: 1),
        transition: Transition.fadeIn,
      );
    } else {
      Get.back();
      Get.snackbar("Error", "",
          backgroundColor: Colors.grey,
          messageText: Text(
            res_data['message'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
    }
  }

  OTPVerification(context, OTPdata) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
    final uri = Uri.parse("${apiGlobal}/user/Verify");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AuthToken}',
    };
    final data = {
      "otp": OTPdata["otp"],
      "deviceType": "android",
      "deviceToken": AuthToken,
    };
    String jsonbody = json.encode(data);

    http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonbody,
    );
    var res_data = json.decode(response.body.toString());
    if (res_data["status"] == true) {
      ResetToken = res_data["data"]["token"].toString();
      Get.back();

      Get.snackbar("Message", "",
          backgroundColor: Colors.grey,
          messageText: Text(
            res_data['message'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
      Get.to(
        () => SetNewPasswordScreen(),
        duration: Duration(seconds: 1),
        transition: Transition.fadeIn,
      );
    } else {
      Get.back();
      Get.snackbar("Error", "",
          backgroundColor: Colors.grey,
          messageText: Text(
            res_data['message'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
    }
  }

  ResetPassword(context, newPasswordData) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
    final uri = Uri.parse("${apiGlobal}/user/resetpassword");

    Map<String, String> headers = {
      "Authorization": 'Bearer ${ResetToken}',
      'Content-Type': 'application/json',
    };

    final data = {
      "password": newPasswordData["password"],
      "deviceType": "android",
      "deviceToken": ResetToken,
    };
    String jsonbody = json.encode(data);

    http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonbody,
    );
    var res_data = json.decode(response.body.toString());
    if (res_data["status"] == true) {
      Get.back();

      Get.snackbar("Message", "",
          backgroundColor: Colors.grey,
          messageText: Text(
            res_data['message'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
      Get.to(
        () => LoginScreen(),
        duration: Duration(seconds: 1),
        transition: Transition.fadeIn,
      );
    } else {
      Get.back();
      Get.snackbar("Error", "",
          backgroundColor: Colors.grey,
          messageText: Text(
            res_data['message'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
    }
  }

  CreateProfile(context, completeProfile, profileimage) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
    final uri = Uri.parse("${apiGlobal}/profile");

    final headers = {'Content-Type': 'application/json'};
    var MyFilename = path.basename(profileimage);
    var request = http.MultipartRequest('POST', uri);

    request.fields['name'] = completeProfile['name'];
    request.fields['lat'] = completeProfile['lat'];
    request.fields['long'] = completeProfile['long'];
    request.fields['phone'] = completeProfile['phone'];
    request.fields['email'] = completeProfile['email'];
    request.fields['password'] = completeProfile['password'];
    request.fields['designation'] = completeProfile['designation'];
    request.fields['deviceType'] = "android";
    request.fields['deviceToken'] = "abc";

    var multipartFile = await http.MultipartFile.fromPath('file', profileimage, filename: MyFilename, contentType: MediaType("image", "jpg"));

    request.files.add(multipartFile);
    request.headers.addAll(headers);

    var res_data = json.encode(request.fields);
    var response = await request.send();
    final res = await http.Response.fromStream(response);
    log("res print" + res.body.toString());
    var _profileData = json.decode(res.body.toString());

    if (_profileData["status"] == true) {
      AuthToken = _profileData["data"]["token"].toString();
      usercontroller.User(userModel.fromJson(_profileData));
      getAddressFromLatLng();

      Get.back();

      Get.snackbar("Message", "",
          backgroundColor: Colors.grey,
          messageText: Text(
            _profileData['message'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
      bottomcontroller.navBarChange(0);
      Get.to(() => NavBarScreen(), duration: Duration(seconds: 1), transition: Transition.fadeIn);
    } else {
      Get.back();
      Get.snackbar("Error", "",
          backgroundColor: Colors.grey,
          messageText: Text(
            _profileData['message'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
    }
  }

  UpdateProfile(context, updateProfiledata, {UserProfileImage}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
    final uri = Uri.parse("${apiGlobal}/user/update");

    final headers = {
      'Authorization': 'Bearer ${AuthToken}',
      'Content-Type': 'application/json',
    };
    var MyFilename;
    if (UserProfileImage != null) {
      MyFilename = path.basename(UserProfileImage);
    }
    // var MyFilename = path.basename(UserProfileImage);
    var request = http.MultipartRequest('POST', uri);

    request.fields['name'] = updateProfiledata['name'];
    request.fields['lat'] = updateProfiledata['lat'];
    request.fields['long'] = updateProfiledata['long'];
    request.fields['phone'] = updateProfiledata['phone'];
    // request.fields['email'] = updateProfiledata['email'];
    request.fields['password'] = updateProfiledata['password'];
    request.fields['designation'] = updateProfiledata['designation'];
    if (UserProfileImage != null) {
      var multipartFile = await http.MultipartFile.fromPath('file', UserProfileImage, filename: MyFilename, contentType: MediaType("image", "jpg"));
      request.files.add(multipartFile);
    }

    // var multipartFile = await http.MultipartFile.fromPath('file', UserProfileImage, filename: MyFilename, contentType: MediaType("image", "jpg"));

    request.headers.addAll(headers);

    var res_data = json.encode(request.fields);
    var response = await request.send();
    final res = await http.Response.fromStream(response);
    log("res print" + res.body.toString());
    var _profileData = json.decode(res.body.toString());

    if (_profileData["status"] == true) {
      usercontroller.User(userModel.fromJson(_profileData));
      getAddressFromLatLng();

      Get.snackbar("Message", "",
          backgroundColor: Colors.grey,
          messageText: Text(
            _profileData['message'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));

      bottomcontroller.navBarChange(3);
      Get.to(() => NavBarScreen(), duration: Duration(seconds: 1), transition: Transition.fadeIn);
    } else {
      Get.back();
      Get.snackbar("Error", "",
          backgroundColor: Colors.grey,
          messageText: Text(
            _profileData['message'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
    }
  }

  getAddressFromLatLng() async {
    dynamic longitude = UserController.user.data!.location!.coordinates![0];
    dynamic latitude = UserController.user.data!.location!.coordinates![1];
    final placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks != null && placemarks.isNotEmpty) {
      final placemark = placemarks[0];
      completeAddress =
          '${placemark.street},${placemark.subLocality},${placemark.locality}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
      return '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
    }
    return "Unable to get address";
  }

  GetPrivacy(context) async {
    final uri = Uri.parse("${apiGlobal}/privacy");
    http.Response response = await http.get(uri);
    var res_data = json.decode(response.body);
    if (res_data["status"] == true) {
      return res_data;
    }
  }

  getTerms() async {
    final uri = Uri.parse("${apiGlobal}/terms");
    http.Response response = await http.get(uri);
    var res_data = jsonDecode(response.body);
    if (res_data["status"] == true) {
      print(res_data["data"]);
      return res_data["data"];
    }
  }
}
