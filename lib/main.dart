import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'Auth/OTPVerification.dart';
import 'Auth/check.dart';

import 'HomeScreens/NavBar.dart';
import 'HomeScreens/Notification.dart';
import 'Splash.dart';
import 'Welcome.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContextcontext) {
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
