import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Auth/check.dart';

import 'Splash.dart';
import 'Welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                GetPage(
                  name: "/SplashScreen",
                  page: () => SplashScreen(),
                ),
                GetPage(
                  name: "/WelcomeScreen",
                  page: () => WelcomeScreen(),
                ),
              ]);
        });
  }
}
