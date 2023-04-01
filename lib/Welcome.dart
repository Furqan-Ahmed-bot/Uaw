import 'package:_uaw/Auth/Adminlogin.dart';
import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var activeindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/Mask Group 3@3x.png"), fit: BoxFit.fill),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Column(
            children: [
              50.verticalSpace,
              CarouselSlider(
                items: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      "assets/images/Group 1428@3x.png",
                    ),
                  ),

                  //2nd Image of Slider
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      "assets/images/Rectangle 990@3x.png",
                    ),
                  ),
                ],

                //Slider Container properties
                options: CarouselOptions(
                  height: 400.0,

                  enlargeCenterPage: true,
                  // autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeindex = index;
                    });
                  },
                  aspectRatio: 0,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
              50.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  dotIndicator(),
                ],
              ),
              20.verticalSpace,
              Text(
                "Welcome to UAW Local 551",
                textAlign: TextAlign.center,
                style: textroboto32,
              ),
              20.verticalSpace,
              Text(
                "The UAW’s commitment to improve the lives of working men and women extends beyond our borders to encompass people around the globe. Through vigilant political involvement and coordination with world labor organizations, we continue to fight for enforcement of trade agreement provisions on human and worker rights, fair labor standards and a new approach to international trade -one that raises the quality of life for working people worldwide.",
                textAlign: TextAlign.center,
                style: textroboto14,
              ),
              30.verticalSpace,
              GestureDetector(
                onTap: () {
                  Get.to(() => AdminLogin(), duration: Duration(seconds: 1), transition: Transition.fadeIn);
                },
                child: Container(
                  width: 80,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: whitecolor,
                  ),
                  child: Center(
                    child: Text(
                      "Skip",
                      style: textroboto18,
                    ),
                  ),
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget dotIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeindex,
        count: 2,
        effect: ExpandingDotsEffect(
          dotWidth: 6,
          dotColor: Color(0xffA4AFBF),
          activeDotColor: Colors.white,
          dotHeight: 6,
        ),
      );
}
