import 'package:_uaw/Auth/Adminlogin.dart';
import 'package:_uaw/Auth/CreateProfile.dart';
import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TermsOfServices extends StatefulWidget {
  const TermsOfServices({super.key});

  @override
  State<TermsOfServices> createState() => _TermsOfServicesState();
}

class _TermsOfServicesState extends State<TermsOfServices> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool swapped = false;
  late AnimationController _controller;
  late List<Animation<Offset>> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _offsetAnimation = List.generate(
      2,
      (index) => Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: Offset(index == 0 ? 1.11 : -1.11, 0),
      ).animate(_controller),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _animate() {
    _controller.status == AnimationStatus.completed ? _controller.reverse() : _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whitish,
      child: Scaffold(
        backgroundColor: transparentcolor,
        appBar: AppBar(
          backgroundColor: transparentcolor,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              "assets/images/Group 1430@3x.png",
              scale: 3,
            ),
          ),
          title: Text(
            "Terms Of Service",
            style: textroboto18,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nullam Porta Diam Id Dolor",
                style: txtstyleblack20,
              ),
              20.verticalSpace,
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae vulputate velit. Nulla facilisi. Fusce interdum ornare arcu, quis accumsan sapien tincidunt vel. Donec tempus nibh a lectus eleifend, at aliquam quam pharetra. Aliquam blandit risus nunc, viverra porttitor ex mattis et. Maecenas accumsan felis et sem pellentesque faucibus. Aliquam facilisis facilisis est, vitae ultricies tortor auctor eget. Aenean ac metus porttitor, interdum mauris iaculis, commodo erat.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae vulputate velit. Nulla facilisi. Fusce interdum ornare arcu, quis accumsan sapien tincidunt vel. Donec tempus nibh a lectus eleifend, at aliquam quam pharetra. Aliquam blandit risus nunc, viverra porttitor ex mattis et. Maecenas accumsan felis et sem pellentesque faucibus. Aliquam facilisis facilisis est, vitae ultricies tortor auctor eget. Aenean ac metus porttitor, interdum mauris iaculis, commodo erat. \n\n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae vulputate velit. Nulla facilisi. Fusce interdum ornare arcu, quis accumsan sapien tincidunt vel. Donec tempus nibh a lectus eleifend, at aliquam quam pharetra. Aliquam blandit risus nunc, viverra porttitor ex mattis et. Maecenas accumsan felis et sem pellentesque faucibus. Aliquam facilisis facilisis est, vitae ultricies tortor auctor eget. Aenean ac metus porttitor, interdum mauris iaculis, commodo erat.",
                style: textroboto15black,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SlideTransition(
                    position: _offsetAnimation[0],
                    child: GestureDetector(
                      onTap: () {
                        _animate();
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
                                      height: 202.h,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Color(0xffFFFFFF)),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      _animate();
                                                    },
                                                  );
                                                  Get.back();
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
                                          0.verticalSpace,
                                          Text(
                                            "Are you sure you want to reject?",
                                            textAlign: TextAlign.center,
                                            style: txtstyleblue25,
                                          ),
                                          20.verticalSpace,
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      _animate();
                                                    },
                                                  );
                                                  Get.back();
                                                },
                                                child: Container(
                                                  width: 162.w,
                                                  height: 55.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.r),
                                                    color: redishcolor,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "No",
                                                      style: medium16white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(() => AdminLogin(), duration: Duration(seconds: 1), transition: Transition.fadeIn);
                                                },
                                                child: Container(
                                                  width: 162.w,
                                                  height: 55.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.r),
                                                    color: bluishshade,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Yes",
                                                      style: medium16white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          20.verticalSpace,
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 189.w,
                        height: 55.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: redishcolor,
                        ),
                        child: Center(
                          child: Text(
                            "Reject",
                            style: txtstylewhite20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Hero(
                    tag: 'myTag-4',
                    transitionOnUserGestures: true,
                    child: Material(
                      type: MaterialType.transparency,
                      child: SlideTransition(
                        position: _offsetAnimation[1],
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              () => CreateProfileScreen(),
                              transition: Transition.fadeIn,
                              duration: Duration(seconds: 1),
                            );
                          },
                          child: Container(
                            width: 189.w,
                            height: 55.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: bluishshade,
                            ),
                            child: Center(
                              child: Text(
                                "Accept",
                                style: txtstylewhite20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
