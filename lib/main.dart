import 'package:_uaw/Service/notification_service.dart';
import 'package:_uaw/test/example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Auth/APIService/API.dart';
import 'Auth/OTPVerification.dart';
import 'Auth/check.dart';

import 'Global.dart';
import 'Helpers.dart';
import 'HomeScreens/NavBar.dart';
import 'HomeScreens/Notification.dart';
import 'Splash.dart';
import 'Welcome.dart';

@pragma('vm:entry-point')
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
  _handleLocationPermission(ContextAction);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

gettoken() {
  FireBaseNotificationServices notificationServices = FireBaseNotificationServices();
  notificationServices.getDeviceToken().then((value) {
    deviceToken = value;
    print('DEVICE TOKEN: $deviceToken');
  });
}

Future<bool> _handleLocationPermission(context) async {
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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final notificationServices = FireBaseNotificationServices();

  @override
  void initState() {
    super.initState();
    gettoken();
    getData();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
  }

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? checkLogin = prefs.getBool("userLogin");
    if (checkLogin == true) {
      AuthToken = prefs.getString('authToken');
      userid = prefs.getString('userId');
      bottomcontroller.navBarChange(0);
      Get.offAll(() => const NavBarScreen(), duration: const Duration(seconds: 1), transition: Transition.fadeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: (context, child) {
          return GetMaterialApp(
              theme: ThemeData(
                textTheme: GoogleFonts.robotoTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
              debugShowCheckedModeBanner: false,
              initialRoute: "/SplashScreen",
              getPages: [
                // GetPage(
                //   name: "/HomeExample",
                //   page: () => HomeExample(),
                // ),
                GetPage(
                  name: "/OTPVerificationScreen",
                  page: () => OTPVerificationScreen(),
                ),
                GetPage(
                  name: "/NavBarScreen",
                  page: () => NavBarScreen(),
                ),
                GetPage(
                  name: "/SplashScreen",
                  page: () => SplashScreen(),
                ),
                GetPage(
                  name: "/WelcomeScreen",
                  page: () => WelcomeScreen(),
                ),
                GetPage(
                  name: "/NotificationScreen",
                  page: () => NotificationScreen(),
                ),
              ]);
        });
  }
}
