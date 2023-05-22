import 'dart:convert';
import 'dart:developer';

import 'package:_uaw/Auth/Login.dart';
import 'package:_uaw/Auth/OTPVerification.dart';
import 'package:_uaw/Controllers/usercontroller.dart';
import 'package:_uaw/Models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Controller.dart';
import '../../Global.dart';
import '../../HomeScreens/NavBar.dart';
import '../SetNewPassword.dart';
import '../TermsOfServices.dart';
import 'dart:io';
import 'package:http_parser/src/media_type.dart';

String apiGlobal = "https://uaw-api.thesuitchstaging.com:3090/api/v1";
final bottomcontroller = Get.put(BottomController());
final usercontroller = Get.put(UserController());

class ApiService {
  uniqueID(context, data) async {
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
      Get.to(
        () => TermsOfServices(),
        duration: Duration(seconds: 1),
        transition: Transition.fadeIn,
      );
    } else {
      Get.snackbar("Error", res_data['message']);
    }
    ;

    return res_data;
  }

  loginAPI(context, loginData) async {
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
      Get.snackbar("Message", res_data["message"]);
      bottomcontroller.navBarChange(0);
      Get.to(() => NavBarScreen(), duration: Duration(seconds: 1), transition: Transition.fadeIn);
    } else {
      Get.snackbar("Error", res_data["message"]);
    }
  }

  forgotPassword(context, forgotpassdata) async {
    final uri = Uri.parse("${apiGlobal}/forgetpassword");
    final headers = {'Content-Type': 'application/json'};

    final body = {
      "email": forgotpassdata["email"],
    };
    http.Response response = await http.post(uri, body: body);

    var res_data = json.decode(response.body.toString());
    if (res_data["status"] == true) {
      AuthToken = res_data["data"]["token"].toString();
      Get.snackbar("Message", res_data["message"]);
      Get.to(
        () => OTPVerificationScreen(),
        duration: Duration(seconds: 1),
        transition: Transition.fadeIn,
      );
    } else {
      Get.snackbar("Error", res_data["message"]);
    }
  }

  OTPVerification(context, OTPdata) async {
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
      Get.snackbar("Message", res_data["message"]);
      Get.to(
        () => SetNewPasswordScreen(),
        duration: Duration(seconds: 1),
        transition: Transition.fadeIn,
      );
    } else {
      Get.snackbar("Error", res_data["message"]);
    }
  }

  ResetPassword(context, newPasswordData) async {
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
      Get.snackbar("Message", res_data["message"]);
      Get.to(
        () => LoginScreen(),
        duration: Duration(seconds: 1),
        transition: Transition.fadeIn,
      );
    } else {
      Get.snackbar("Error", res_data["message"]);
    }
  }

  CreateProfile(context, completeProfile, profileimage) async {
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
      usercontroller.User(userModel.fromJson(_profileData));
      Get.snackbar("Message", _profileData['message']);
      bottomcontroller.navBarChange(0);
      Get.to(() => NavBarScreen(), duration: Duration(seconds: 1), transition: Transition.fadeIn);
    } else {
      Get.snackbar("Error", _profileData['message']);
    }
  }
}
