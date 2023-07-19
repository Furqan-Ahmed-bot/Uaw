import 'package:_uaw/Auth/APIService/API.dart';
import 'package:_uaw/Controllers/magazinecontroller.dart';
import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Controller.dart';
import '../downloadfiles.dart';
import 'NavBar.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class MagzineScreen extends StatefulWidget {
  final String value;
  const MagzineScreen({super.key, required this.value});

  @override
  State<MagzineScreen> createState() => _MagzineScreenState();
}

class _MagzineScreenState extends State<MagzineScreen> {
  dynamic fileName;
  Future<void> _magazindownload(url, filename) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // final appDocumentsDirectory = await getApplicationDocumentsDirectory();
      Object appDocumentsDirectory = Platform.isAndroid
          ? (await getExternalStorageDirectory())!.path //FOR ANDROID
          : (await getApplicationSupportDirectory()).path;
      final filePath = '$appDocumentsDirectory/$filename}';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      // Open the document
      final documentUrl = file.path;
      if (await canLaunch(documentUrl)) {
        await launch(documentUrl);
      } else {
        print('Could not open the document');
      }

      print('Document downloaded to: $filePath');
      // Handle the downloaded file, e.g., open or share it
    } else {
      print('Failed to download the document. Status code: ${response.statusCode}');
      // Handle error, such as displaying an error message to the user
    }
  }

  final bottomcontroller = Get.put(BottomController());
  List imagelist = [
    {"userimage": "assets/images/Ellipse 68-1@3x.png"},
    {"userimage": "assets/images/Ellipse 68@3x.png"},
    {"userimage": "assets/images/krakenimages-Y5bvRlcCx8k-unsplash@3x.png"},
  ];
  String now = DateFormat("yyyy-MM-dd").format(DateTime.now());
  int i = 0;
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    ApiService().getMagazine();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      color: whitish,
      child: Scaffold(
        backgroundColor: transparentcolor,
        appBar: AppBar(
          backgroundColor: transparentcolor,
          elevation: 0,
          leadingWidth: 70,
          leading: Center(
            child: GestureDetector(
              onTap: () {
                if (bottomcontroller.navigationBarIndexValue != 0) {
                  bottomcontroller.navBarChange(0);
                } else {
                  Get.back();
                }
              },
              child: Image.asset(
                "assets/images/Group 1430@3x.png",
                scale: 2.5,
              ),
            ),
          ),
          title: Hero(
            transitionOnUserGestures: true,
            tag: ValueKey(widget.value),
            child: Text(
              "MAGAZINES",
              style: textroboto18,
            ),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<MagazineController>(builder: (magazinecontroller) {
          return magazinecontroller.isLoding && magazinecontroller.MagzineData.isEmpty
              ? Center(child: const CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.r),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        15.verticalSpace,
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: magazinecontroller.MagzineData.length,
                            itemBuilder: (BuildContext context, index) {
                              fileName = magazinecontroller.MagzineData[index]["file"][0];

                              String filename2 = fileName.split('/').last;
                              print(filename2);
                              String capitalizeFirstLetter(String text) {
                                if (text.isEmpty) return text;

                                final firstLetter = text.substring(0, 1).toUpperCase();
                                final remainingLetters = text.substring(1);
                                return '$firstLetter$remainingLetters';
                              }

                              String AdminName = magazinecontroller.MagzineData[index]["user"]["name"];
                              String capitalizedTitle = capitalizeFirstLetter(AdminName);
                              return Column(
                                children: [
                                  Container(
                                    width: 1.sw,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          20.verticalSpace,
                                          Row(
                                            // crossAxisAlignment: CrossAxisAlignment.end,
                                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 60.h,
                                                        height: 60.h,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                            image: AssetImage(
                                                              "assets/images/Ellipse 68-1@3x.png",
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      10.horizontalSpace,
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            capitalizedTitle,
                                                            style: txtstyleblue17,
                                                          ),
                                                          5.verticalSpace,
                                                          Text(
                                                            magazinecontroller.MagzineData[index]["date"],
                                                            style: textroboto12,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  10.verticalSpace,
                                                  Container(
                                                      width: 0.84.sw,
                                                      height: 0.3.sh,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                        image: NetworkImage(
                                                            "https://uaw-api.thesuitchstaging.com:3090/${magazinecontroller.MagzineData[index]["coverImage"]["file"]}"),
                                                        fit: BoxFit.fill,
                                                      )),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
                                                            child: Row(
                                                              // mainAxisAlignment: MainAxisAlignment.end,
                                                              // crossAxisAlignment: CrossAxisAlignment.end,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    showDialog(
                                                                        context: context,
                                                                        builder: (context) => DownloadingDialogFile(
                                                                            url:
                                                                                'https://uaw-api.thesuitchstaging.com/Uploads/${magazinecontroller.MagzineData[index]["file"][0]}'));
                                                                    // openFile();
                                                                    // Replace with the actual document URL from the API response
                                                                    _magazindownload(
                                                                        'https://uaw-api.thesuitchstaging.com/Uploads/${magazinecontroller.MagzineData[index]["file"][0]}',
                                                                        filename2);

                                                                    // showDialog(
                                                                    //   context: context,
                                                                    //   builder: (context) => const DownloadingDialog(),
                                                                    // );
                                                                  },
                                                                  child: Image.asset(
                                                                    "assets/images/Group 1435@3x.png",
                                                                    scale: 3.5,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  //  DecorationImage(
                                                  //   image:
                                                  //   NetworkImage(
                                                  //       'https://uaw-api.thesuitchstaging.com:3090/${documentcontroller.DocumentsData[0]["coverImage"]["file"]}'),
                                                  // ),
                                                  // Container(
                                                  //   width: 175.w,
                                                  //   height: 200.h,
                                                  //   decoration: BoxDecoration(
                                                  //     borderRadius: BorderRadius.circular(10.r),
                                                  //     image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                                  //     color: black,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              10.horizontalSpace,
                                              // Container(
                                              //   width: 175.w,
                                              //   height: 248.h,
                                              //   decoration: BoxDecoration(
                                              //     borderRadius: BorderRadius.circular(10.r),
                                              //     image: DecorationImage(image: AssetImage("assets/images/Group 1440@3x.png"), fit: BoxFit.fill),
                                              //     color: black,
                                              //   ),
                                              //   child: Padding(
                                              //     padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
                                              //     child: Row(
                                              //       mainAxisAlignment: MainAxisAlignment.end,
                                              //       crossAxisAlignment: CrossAxisAlignment.end,
                                              //       children: [
                                              //         Image.asset(
                                              //           "assets/images/Group 1435@3x.png",
                                              //           scale: 3.5,
                                              //         )
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          15.verticalSpace,
                                          10.verticalSpace,
                                          Row(
                                            children: [
                                              Text(magazinecontroller.MagzineData[index]["title"]),
                                            ],
                                          ),
                                          // if (magazinecontroller.MagzineData[index]["title"] == null) ...[
                                          //   Text("No Content")
                                          // ] else ...[
                                          //   magazinecontroller.MagzineData[index]["title"]
                                          // ],
                                          20.verticalSpace,
                                        ],
                                      ),
                                    ),
                                  ),
                                  15.verticalSpace,
                                ],
                              );
                            })
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
