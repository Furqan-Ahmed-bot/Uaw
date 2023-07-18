import 'dart:convert';
import 'dart:developer';
import 'package:_uaw/Controllers/notificationcontroller.dart';
import 'package:flutter/material.dart' as image;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:_uaw/Auth/Login.dart';
import 'package:_uaw/Auth/OTPVerification.dart';
import 'package:_uaw/Controllers/documentscontroller.dart';
import 'package:_uaw/Controllers/magazinecontroller.dart';
import 'package:_uaw/Controllers/usercontroller.dart';
import 'package:_uaw/Controllers/videocontroller.dart';
import 'package:_uaw/Models/usermodel.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as path;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Controller.dart';
import '../../Controllers/eventcontroller.dart';
import '../../Controllers/feedscontroller.dart';
import '../../Global.dart';
import '../../Helpers.dart';
import '../../HomeScreens/NavBar.dart';
import '../../HomeScreens/NewsAndEvents.dart';
import '../../HomeScreens/Settings.dart';
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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("userLogin", false);
      Get.snackbar("Message", resData["message"]);
      Get.to(() => const LoginScreen(), duration: const Duration(seconds: 1), transition: Transition.fadeIn);
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();

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
      "deviceToken": deviceToken,
    };
    http.Response response = await http.post(
      uri,
      body: body,
    );
    var resData = json.decode(response.body.toString());

    if (resData["status"] == true) {
      usercontroller.User(userModel.fromJson(resData));
      String userModelJson = json.encode(resData);
      SharedPreferences.getInstance().then(
        (prefs) {
          prefs.setString("globaltoken", resData["data"]["token"]);
          prefs.setString("model", userModelJson);
        },
      );
      AuthToken = resData["data"]["token"].toString();
      userid = resData["data"]["_id"].toString();
      toggle = resData["data"]["notificationOn"];
      designationTitle = resData["data"]["designation"]["title"];
      await prefs.setString('authToken', AuthToken);
      await prefs.setString('userId', userid);
      await prefs.setBool('toggle', toggle);
      await prefs.setBool("userLogin", true);

      // getAddressFromLatLng();
      Get.back();
      Get.snackbar("Message", resData["message"]);

      bottomcontroller.navBarChange(0);
      Get.to(() => const NavBarScreen(), duration: const Duration(seconds: 1), transition: Transition.fadeIn);
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
      "deviceToken": deviceToken,
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
    request.fields["location"] = completeProfile["location"];
    // request.fields['lat'] = completeProfile['lat'];
    // request.fields['long'] = completeProfile['long'];
    request.fields['phone'] = completeProfile['phone'];
    request.fields['email'] = completeProfile['email'];
    request.fields['password'] = completeProfile['password'];
    request.fields['designation'] = completeProfile['designation'];
    request.fields['deviceType'] = "android";
    request.fields['deviceToken'] = deviceToken;

    print("Device Token $deviceToken");

    var multipartFile = await http.MultipartFile.fromPath('file', profileimage, filename: MyFilename, contentType: MediaType("image", "jpg"));

    request.files.add(multipartFile);
    request.headers.addAll(headers);

    var resData = json.encode(request.fields);
    var response = await request.send();
    final res = await http.Response.fromStream(response);
    log("res print${res.body}");
    var profileData = json.decode(res.body.toString());

    if (profileData["status"] == true) {
      AuthToken = profileData["data"]["token"].toString();
      toggle = profileData["data"]["notificationOn"];
      usercontroller.User(userModel.fromJson(profileData));

      // getAddressFromLatLng();

      Get.back();
      Get.snackbar("Message", profileData['message']);
      bottomcontroller.navBarChange(0);
      Get.to(() => const NavBarScreen(), duration: const Duration(seconds: 1), transition: Transition.fadeIn);
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
    // request.fields['lat'] = updateProfiledata['lat'];
    // request.fields['long'] = updateProfiledata['long'];
    request.fields['phone'] = updateProfiledata['phone'];
    request.fields["location"] = updateProfiledata["location"];
    // request.fields['email'] = updateProfiledata['email'];
    request.fields['password'] = updateProfiledata['password'];
    request.fields['designation'] = updateProfiledata['designation'];
    if (UserProfileImage != null) {
      var multipartFile = await http.MultipartFile.fromPath('file', UserProfileImage, filename: MyFilename, contentType: MediaType("image", "jpg"));
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
      // getAddressFromLatLng();

      Get.snackbar("Message", profileData['message']);

      bottomcontroller.navBarChange(3);
      Get.to(() => const NavBarScreen(), duration: const Duration(seconds: 1), transition: Transition.fadeIn);
    } else {
      Get.back();
      Get.snackbar("Error", profileData['message']);
    }
  }

  rejectEvent(eventid, context) async {
    final uri = Uri.parse("$apiGlobal/removeuser/$eventid");
    var data = {"uid": userid};
    http.Response response = await http.patch(
      uri,
      body: data,
    );
    var resData = json.decode(response.body.toString());
    if (resData["status"] == true) {
      Get.snackbar("Message", resData["message"]);
      bottomcontroller.navBarChange(1);
      Get.to(() => const NavBarScreen(), duration: const Duration(seconds: 1), transition: Transition.fadeIn);
    } else {
      Get.snackbar("Message", resData["message"]);
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
      ApiService().geteventbyuser();
      Get.snackbar('Message', resData['message']);
      bottomcontroller.navBarChange(1);
      Get.to(() => NavBarScreen());
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => const NewsAndEventsScreen(
      //           value: '',
      //         )));
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

  getDocumnets() async {
    final documentcontroller = Get.put(DocumentController());
    documentcontroller.setLoading(true);
    final uri = Uri.parse("$apiGlobal/document");
    http.Response response = await http.get(uri);
    var resData = jsonDecode(response.body.toString());

    if (resData["status"] == true) {
      documentcontroller.setLoading(false);
      documentcontroller.getDocumentsData(resData["data"]);
    }
  }

  getNotifications() async {
    final notificationcontroller = Get.put(NotificationController());
    notificationcontroller.setLoading(true);
    final uri = Uri.parse("$apiGlobal/user/notification");
    var headers = {'Authorization': 'Bearer $AuthToken'};
    print(headers);
    http.Response response = await http.get(uri, headers: headers);
    var resData = jsonDecode(response.body.toString());

    if (resData["status"] == true) {
      notificationcontroller.setLoading(false);
      notificationcontroller.getNotificationsData(resData["data"]);
    } else {
      Get.snackbar("message", resData["message"]);
      notificationcontroller.setLoading(false);
    }
  }

  getMagazine() async {
    final magazinecontroller = Get.put(MagazineController());
    magazinecontroller.setLoading(true);
    final uri = Uri.parse("$apiGlobal/magazine");
    http.Response response = await http.get(uri);
    var resData = jsonDecode(response.body.toString());

    if (resData["status"] == true) {
      magazinecontroller.setLoading(false);
      magazinecontroller.getMagzinesData(resData["data"]);
    }
  }

  getVideo() async {
    final videocontroller = Get.put(VideoController());
    videocontroller.setLoading(true);
    final uri = Uri.parse("$apiGlobal/video");
    http.Response response = await http.get(uri);
    var resData = jsonDecode(response.body.toString());
    if (resData["status"] == true) {
      videocontroller.setLoading(false);
      videocontroller.getvideoData(resData["data"]);
    }
  }

  getFeeds() async {
    final feedscontroller = Get.put(feedsController());
    feedscontroller.setLoading(true);
    final uri = Uri.parse("$apiGlobal/allcontent");
    http.Response response = await http.get(uri);
    var resData = jsonDecode(response.body.toString());
    if (resData["status"] == true) {
      feedscontroller.setLoading(false);
      feedscontroller.getFeeds(resData["data"]);
    }
  }

  // getAddressFromLatLng() async {
  //   dynamic longitude = UserController.user.data!.location!.coordinates![0];
  //   dynamic latitude = UserController.user.data!.location!.coordinates![1];
  //   final placemarks = await placemarkFromCoordinates(latitude, longitude);
  //   if (placemarks.isNotEmpty) {
  //     final placemark = placemarks[0];
  //     completeAddress =
  //         '${placemark.street},${placemark.subLocality},${placemark.locality}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
  //     return '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
  //   }
  //   return "Unable to get address";
  // }

  getTerms() async {
    final uri = Uri.parse("$apiGlobal/terms");
    http.Response response = await http.get(uri);
    var resData = jsonDecode(response.body);
    if (resData["status"] == true) {
      print(resData["data"]);
      return resData["data"];
    }
  }

  getAbout() async {
    final uri = Uri.parse("$apiGlobal/about");
    http.Response response = await http.get(uri);
    var resData = jsonDecode(response.body);
    if (resData["status"] == true) {
      return resData;
    }
  }

  GetPrivacy(context) async {
    final uri = Uri.parse("$apiGlobal/privacy");
    http.Response response = await http.get(uri);
    var resData = json.decode(response.body);
    if (resData["status"] == true) {
      return resData;
    }
  }

  helpandsupport(context, helpformDetails) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
    final uri = Uri.parse("$apiGlobal/user/contact");
    final headers = {
      "Authorization": "Bearer $AuthToken",
      'Content-Type': 'application/json',
    };

    final body = {
      "email": helpformDetails["email"],
      "name": helpformDetails["name"],
      "phone": helpformDetails["phone"],
      "message": helpformDetails["message"],
    };
    final postData = json.encode(body);
    http.Response response = await http.post(uri, headers: headers, body: postData);

    var resData = json.decode(response.body.toString());
    if (resData["status"] == true) {
      showDialog(
        barrierDismissible: true,
        // barrierColor: Colors.white,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                insetPadding: EdgeInsets.zero,
                backgroundColor: Color(0xff000000B8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0.r),
                ),
                contentPadding: EdgeInsets.all(0),
                actionsPadding: EdgeInsets.all(0),
                actions: [
                  Container(
                    width: 370.w,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Color(0xffFFFFFF)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                bottomcontroller.navBarChange(0);
                                Get.to(() => const NavBarScreen(), duration: const Duration(seconds: 1), transition: Transition.fadeIn);
                              },
                              child: Container(
                                width: 35.w,
                                height: 35.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.r),
                                    topRight: Radius.circular(15.r),
                                  ),
                                  color: bluishshade,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: white,
                                  size: 25.r,
                                ),
                              ),
                            )
                          ],
                        ),
                        20.verticalSpace,
                        Center(
                            child: Icon(
                          Icons.abc,
                        )
                            // Image.asset(
                            //   "assets/images/check@3x.png",
                            //   scale: 3.5,
                            // ),
                            ),
                        Text(
                          "Success",
                          textAlign: TextAlign.center,
                          style: txtstyleblack26bold,
                        ),
                        20.verticalSpace,
                        Container(
                          width: 0.6.sw,
                          child: Text(
                            "Form Submitted Successfully",
                            textAlign: TextAlign.center,
                            style: textrobotobluishshade22Medium,
                          ),
                        ),
                        40.verticalSpace,
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    } else {
      Get.back();
      Get.snackbar("Error", resData["message"]);
    }
  }
}
