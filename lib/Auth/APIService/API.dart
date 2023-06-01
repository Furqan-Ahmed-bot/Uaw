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
import '../../Controllers/eventcontroller.dart';
import '../../Global.dart';
import '../../HomeScreens/NavBar.dart';
import '../../HomeScreens/NewsAndEvents.dart';
import '../Prelogin.dart';
import '../SetNewPassword.dart';
import '../TermsOfServices.dart';
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
          return const SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
    final uri = Uri.parse("$apiGlobal/user/logout");
    final headers = {
      'Authorization': 'Bearer $AuthToken',
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
    var resData = json.decode(response.body.toString());
    if (resData["status"] == true) {
      Get.snackbar("Message", resData["message"]);
      Get.to(() => const PreloginScreen(),
          duration: const Duration(seconds: 1), transition: Transition.fadeIn);
    } else {
      Get.back();
      Get.snackbar("Error", resData['message']);
    }
  }

  uniqueID(context, data) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
    final uri = Uri.parse("$apiGlobal/verifyuniqueid");

    final body = {
      'email': data['email'],
    };
    http.Response response = await http.post(
      uri,
      body: body,
    );
    var resData = json.decode(response.body.toString());

    if (resData['status'] == true) {
      uniqieemail = data['email'];
      Get.back();

      Get.to(
        () => const TermsOfServices(),
        duration: const Duration(seconds: 1),
        transition: Transition.fadeIn,
      );
    } else {
      Get.back();
      Get.snackbar("Error", "",
          backgroundColor: Colors.grey,
          messageText: Text(
            resData['message'],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
    }

    return resData;
  }

  loginAPI(context, loginData) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
    final uri = Uri.parse("$apiGlobal/login");
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
    var resData = json.decode(response.body.toString());

    if (resData["status"] == true) {
      usercontroller.User(userModel.fromJson(resData));
      AuthToken = resData["data"]["token"].toString();
      userid = resData["data"]["_id"].toString();

      getAddressFromLatLng();
      Get.back();
      Get.snackbar("Message", resData["message"]);
      bottomcontroller.navBarChange(0);
      Get.to(() => const NavBarScreen(),
          duration: const Duration(seconds: 1), transition: Transition.fadeIn);
    } else {
      Get.back();
      Get.snackbar("Error", resData["message"]);
    }
  }

  forgotPassword(context, forgotpassdata) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
    final uri = Uri.parse("$apiGlobal/forgetpassword");
    final headers = {'Content-Type': 'application/json'};

    final body = {
      "email": forgotpassdata["email"],
    };
    http.Response response = await http.post(uri, body: body);

    var resData = json.decode(response.body.toString());
    if (resData["status"] == true) {
      AuthToken = resData["data"]["token"].toString();
      Get.back();
      Get.snackbar("Message", resData["message"]);
      Get.to(
        () => OTPVerificationScreen(),
        duration: const Duration(seconds: 1),
        transition: Transition.fadeIn,
      );
    } else {
      Get.back();
      Get.snackbar("Error", resData["message"]);
    }
  }

  Events(context) async {
    final eventcontroller = Get.put(EventController());
    eventcontroller.setLoading(true);
    final uri = Uri.parse("$apiGlobal/user/getnewevents");
    var header = {'Authorization': 'Bearer $AuthToken'};
    http.Response response = await http.get(uri, headers: header);
    var resData = json.decode(response.body.toString());
    if (resData['status'] == true) {
      eventcontroller.setLoading(false);
      // usercontroller.Events(EventModel.fromJson(resData));
      eventcontroller.getEventsData(resData['data']);
    }
  }

  OTPVerification(context, OTPdata) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
    final uri = Uri.parse("$apiGlobal/user/Verify");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $AuthToken',
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
    var resData = json.decode(response.body.toString());
    if (resData["status"] == true) {
      ResetToken = resData["data"]["token"].toString();
      Get.back();
      Get.snackbar("Message", resData["message"]);
      Get.to(
        () => const SetNewPasswordScreen(),
        duration: const Duration(seconds: 1),
        transition: Transition.fadeIn,
      );
    } else {
      Get.back();
      Get.snackbar("Error", resData["message"]);
    }
  }

  ResetPassword(context, newPasswordData) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
    final uri = Uri.parse("$apiGlobal/user/resetpassword");

    Map<String, String> headers = {
      "Authorization": 'Bearer $ResetToken',
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
    var resData = json.decode(response.body.toString());
    if (resData["status"] == true) {
      Get.back();
      Get.snackbar("Message", resData["message"]);
      Get.to(
        () => const LoginScreen(),
        duration: const Duration(seconds: 1),
        transition: Transition.fadeIn,
      );
    } else {
      Get.back();
      Get.snackbar("Error", resData["message"]);
    }
  }

  CreateProfile(context, completeProfile, profileimage) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
    final uri = Uri.parse("$apiGlobal/profile");

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

    var multipartFile = await http.MultipartFile.fromPath('file', profileimage,
        filename: MyFilename, contentType: MediaType("image", "jpg"));

    request.files.add(multipartFile);
    request.headers.addAll(headers);

    var resData = json.encode(request.fields);
    var response = await request.send();
    final res = await http.Response.fromStream(response);
    log("res print${res.body}");
    var profileData = json.decode(res.body.toString());

    if (profileData["status"] == true) {
      AuthToken = profileData["data"]["token"].toString();
      usercontroller.User(userModel.fromJson(profileData));
      getAddressFromLatLng();

      Get.back();
      Get.snackbar("Message", profileData['message']);
      bottomcontroller.navBarChange(0);
      Get.to(() => const NavBarScreen(),
          duration: const Duration(seconds: 1), transition: Transition.fadeIn);
    } else {
      Get.back();
      Get.snackbar("Error", profileData['message']);
    }
  }

  UpdateProfile(context, updateProfiledata, {UserProfileImage}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
    final uri = Uri.parse("$apiGlobal/user/update");

    final headers = {
      'Authorization': 'Bearer $AuthToken',
      'Content-Type': 'application/json',
    };
    dynamic MyFilename;
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
      var multipartFile = await http.MultipartFile.fromPath(
          'file', UserProfileImage,
          filename: MyFilename, contentType: MediaType("image", "jpg"));
      request.files.add(multipartFile);
    }

    // var multipartFile = await http.MultipartFile.fromPath('file', UserProfileImage, filename: MyFilename, contentType: MediaType("image", "jpg"));

    request.headers.addAll(headers);

    var resData = json.encode(request.fields);
    var response = await request.send();
    final res = await http.Response.fromStream(response);
    log("res print${res.body}");
    var profileData = json.decode(res.body.toString());

    if (profileData["status"] == true) {
      usercontroller.User(userModel.fromJson(profileData));
      getAddressFromLatLng();

      Get.snackbar("Message", profileData['message']);

      bottomcontroller.navBarChange(3);
      Get.to(() => const NavBarScreen(),
          duration: const Duration(seconds: 1), transition: Transition.fadeIn);
    } else {
      Get.back();
      Get.snackbar("Error", profileData['message']);
    }
  }

  joinEvent(eventid, context) async {
    final uri = Uri.parse("$apiGlobal/joinevent/$eventid");
    var data = {'uid': userid};
    http.Response response = await http.patch(
      uri,
      body: data,
    );
    var resData = json.decode(response.body.toString());
    if (resData['status'] == true) {
      // Get.snackbar('Message', resData['message']);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const NewsAndEventsScreen(
                value: '',
              )));
      // Get.to(const NewsAndEventsScreen(
      //   value: '',
      // ));
    }
  }

  geteventbyuser() async {
    final eventcontroller = Get.put(EventController());
    eventcontroller.setLoading(true);
    final uri = Uri.parse("$apiGlobal/user/getmyevents");
    var headers = {'Authorization': 'Bearer $AuthToken'};
    http.Response response = await http.get(uri, headers: headers);
    var resData = json.decode(response.body.toString());

    if (resData['status'] == true) {
      eventcontroller.setLoading(false);
      eventcontroller.getMyEvents(resData['data']);
    }
  }

  getAddressFromLatLng() async {
    dynamic longitude = UserController.user.data!.location!.coordinates![0];
    dynamic latitude = UserController.user.data!.location!.coordinates![1];
    final placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      final placemark = placemarks[0];
      completeAddress =
          '${placemark.street},${placemark.subLocality},${placemark.locality}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
      return '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
    }
    return "Unable to get address";
  }
}
