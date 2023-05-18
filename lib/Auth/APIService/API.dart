import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Global.dart';
import '../TermsOfServices.dart';

String apiGlobal = "https://uaw-api.thesuitchstaging.com:3090/api/v1";



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



  CreateProfile(context, createProfiledata) async {
    final uri = Uri.parse("${apiGlobal}/profile");

    final body = {
      "name": createProfiledata['name'],
      "lat": createProfiledata['lat'],
      "long": createProfiledata['long'],
      "phone": createProfiledata['phone'],
      "email": createProfiledata['email'],
    };
  }

  // getDesignation() async {
  //   final uri = Uri.parse("${apiGlobal}designation");
  //   final headers = { "Authorization" : "abc"};

  // }
}
