// ignore_for_file: unused_import

import 'dart:convert';

import 'package:_uaw/Controllers/documentscontroller.dart';
import 'package:_uaw/Helpers.dart';
import 'package:_uaw/HomeScreens/NavBar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

//import 'package:open_file/open_file.dart';

import '../Auth/APIService/API.dart';
import '../Controller.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../downloadfiles.dart';
import '../mywebview.dart';
import 'downloaddialouge.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class DocumentsScreen extends StatefulWidget {
  final String value;

  const DocumentsScreen({super.key, required this.value});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> with SingleTickerProviderStateMixin {
  final documentcontroller = Get.put((DocumentController));

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;

    final firstLetter = text.substring(0, 1).toUpperCase();
    final remainingLetters = text.substring(1);
    return '$firstLetter$remainingLetters';
  }

  dynamic fileName;
  Future<void> _downloadDocument(String url, String filename) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final appDocumentsDirectory = await getApplicationDocumentsDirectory();

      final filePath = '${appDocumentsDirectory.path}/$filename';
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
  // Future<void> _downloadDocument(url, filename) async {
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     final appDownloadsDirectory = await getExternalStorageDirectory();

  //     final filePath = '${appDownloadsDirectory!.path}/${filename}}';
  //     await Directory(filePath).create(recursive: true);

  //     final file = File(filePath);
  //     final filepath = '$filePath/$filename';
  //     await file.writeAsBytes(response.bodyBytes);

  //     // Open the document
  //     final documentUrl = file.path;
  //     if (await canLaunch(documentUrl)) {
  //       await launch(documentUrl);
  //     } else {
  //       print('Could not open the document');
  //     }

  //     print('Document downloaded to: $filePath');
  //     // Handle the downloaded file, e.g., open or share it
  //   } else {
  //     print('Failed to download the document. Status code: ${response.statusCode}');
  //     // Handle error, such as displaying an error message to the user
  //   }
  // }

  // Future<String> _createFileFromString(String myfile, String extension) async {
  //   final encodedStr = myfile;
  //   Uint8List bytes = base64.decode(encodedStr);
  //   String dir = (await getTemporaryDirectory()).path;
  //   File file = File("$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + extension);
  //   await file.writeAsBytes(bytes);
  //   OpenFile.open(file.path);
  //   return file.path;
  // }

  // var _openResult = 'Unknown';
  // final directory = getApplicationDocumentsDirectory();

  // Future<void> openFile() async {
  //   final filePath = 'https://uaw-api.thesuitchstaging.com/Uploads/1685717995211-dummy.pdf';
  //   final result = await OpenFile.open(filePath);

  //   setState(() {
  //     _openResult = "type=${result.type}  message=${result.message}";
  //   });
  // }

  // Future<void> downloadFile(String url, String fileName) async {
  //   url =
  //       "https://firebasestorage.googleapis.com/v0/b/e-commerce-72247.appspot.com/o/195-1950216_led-tv-png-hd-transparent-png.png?alt=media&token=0f8a6dac-1129-4b76-8482-47a6dcc0cd3e";
  //   var response = await http.get(Uri.parse(url));
  //   var filePath = await _localPath(fileName);
  //   File file = File(filePath);
  //   await file.writeAsBytes(response.bodyBytes);
  //   print('File has been downloaded at $filePath');
  // }

  // Future<String> _localPath(String fileName) async {
  //   final directory = await getExternalStorageDirectory();
  //   return '${directory?.path}/$fileName';
  // }

  final bottomcontroller = Get.put(BottomController());
  String now = DateFormat("yyyy-MM-dd").format(DateTime.now());
  List DocumentDetails = [
    {"userimage": "assets/images/Ellipse 68-1@3x.png"},
    {"userimage": "assets/images/Ellipse 68@3x.png"},
    {"userimage": "assets/images/krakenimages-Y5bvRlcCx8k-unsplash@3x.png"},
  ];
  void initState() {
    ApiService().getDocumnets();

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
              "DOCUMENTS",
              style: textroboto18,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: SingleChildScrollView(
            child: GetBuilder<DocumentController>(
              builder: (documentcontroller) {
                return documentcontroller.isLoding && documentcontroller.DocumentsData.isEmpty
                    ? Center(child: const CircularProgressIndicator())
                    : Column(
                        children: [
                          35.verticalSpace,
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: documentcontroller.DocumentsData.length,
                              itemBuilder: (BuildContext context, index) {
                                fileName = documentcontroller.DocumentsData[index]["file"][0].isEmpty
                                    ? "1687804803619-Free_Test_Data_500KB_PDF.pdf"
                                    : documentcontroller.DocumentsData[index]["file"][0];

                                String filename2 = fileName.split('/').last;
                                print(filename2);
                                String capitalizeFirstLetter(String text) {
                                  if (text.isEmpty) return text;

                                  final firstLetter = text.substring(0, 1).toUpperCase();
                                  final remainingLetters = text.substring(1);
                                  return '$firstLetter$remainingLetters';
                                }

                                String AdminName = documentcontroller.DocumentsData[index]["user"]["name"];
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
                                        padding: EdgeInsets.symmetric(horizontal: 20.r),
                                        child: Column(
                                          children: [
                                            20.verticalSpace,
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
                                                15.horizontalSpace,
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      capitalizedTitle,
                                                      style: txtstyleblue17,
                                                    ),
                                                    5.verticalSpace,
                                                    Text(
                                                      documentcontroller.DocumentsData[index]["date"],
                                                      // DateFormat(
                                                      //   "MMM dd yyyy",
                                                      // ).format(
                                                      //   DateTime.now(),
                                                      // ),
                                                      style: textroboto12,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            15.verticalSpace,
                                            Container(
                                              width: 0.9.sw,
                                              height: 250.h,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.r),
                                                color: whitecolor,
                                                image:

                                                    //  DecorationImage(
                                                    //   image:
                                                    //   NetworkImage(
                                                    //       'https://uaw-api.thesuitchstaging.com:3090/${documentcontroller.DocumentsData[0]["coverImage"]["file"]}'),
                                                    // ),
                                                    documentcontroller.DocumentsData[index]["file"][0].endsWith('.txt') ||
                                                            documentcontroller.DocumentsData[index]["file"][0].endsWith('.docx') ||
                                                            documentcontroller.DocumentsData[index]["file"][0].endsWith('.doc')
                                                        ? const DecorationImage(image: AssetImage("assets/images/unnamed.png"), scale: 4
                                                            // fit: BoxFit.contain,
                                                            )
                                                        : DecorationImage(
                                                            image: AssetImage("assets/images/download.png"), scale: 2,
                                                            // fit: BoxFit.contain,
                                                          ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(right: 10.r, bottom: 10.r),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (documentcontroller.DocumentsData[index]["file"][0].endsWith('.docx') ||
                                                            documentcontroller.DocumentsData[index]["file"][0].endsWith('.doc')) {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) => DownloadingDialogFile(
                                                                  url:
                                                                      'https://uaw-api.thesuitchstaging.com/Uploads/${documentcontroller.DocumentsData[index]["file"][0]}'));
                                                          // openFile();
                                                          // Replace with the actual document URL from the API response
                                                          _downloadDocument(documentcontroller.DocumentsData[index]["file"][0], filename2);
                                                          // launchUrl(
                                                          //     Uri.parse(
                                                          //         "https://docs.google.com/gview?embedded=true&url=https://uaw-api.thesuitchstaging.com/Uploads/${documentcontroller.DocumentsData[index]["file"][0]}" ??
                                                          //             ''),
                                                          //     mode: LaunchMode.externalNonBrowserApplication);

                                                          // print(launchUrl);
                                                        } else {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) => DownloadingDialogFile(
                                                                  url:
                                                                      'https://uaw-api.thesuitchstaging.com/Uploads/${documentcontroller.DocumentsData[index]["file"][0]}'));
                                                          // openFile();
                                                          // Replace with the actual document URL from the API response
                                                          print("UAWWW : " + documentcontroller.DocumentsData[index]["file"][0].toString());
                                                          _downloadDocument(
                                                              'https://uaw-api.thesuitchstaging.com/Uploads/${documentcontroller.DocumentsData[index]["file"][0]}',
                                                              filename2);

                                                          // showDialog(
                                                          //   context: context,
                                                          //   builder: (context) => const DownloadingDialog(),
                                                          // );
                                                        }
                                                        // showDialog(
                                                        //     context: context,
                                                        //     builder: (context) => DownloadingDialogFile(
                                                        //         url:
                                                        //             'https://uaw-api.thesuitchstaging.com/Uploads/${documentcontroller.DocumentsData[index]["file"][0]}'));
                                                        // // openFile();
                                                        // // Replace with the actual document URL from the API response
                                                        // _downloadDocument(documentcontroller.DocumentsData[index]["file"][0],
                                                        //
                                                        //
                                                        // );

                                                        // showDialog(
                                                        //   context: context,
                                                        //   builder: (context) => const DownloadingDialog(),
                                                        // );
                                                      },
                                                      child: Image.asset(
                                                        "assets/images/Group 1435@3x.png",
                                                        scale: 2.5,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            10.verticalSpace,
                                            Row(
                                              children: [
                                                Text(
                                                  documentcontroller.DocumentsData[index]["title"],
                                                  style: textroboto15,
                                                ),
                                              ],
                                            ),
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
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class DocumentWidget extends StatelessWidget {
  String userimage;
  DocumentWidget({
    required this.userimage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            child: Column(
              children: [
                20.verticalSpace,
                Row(
                  children: [
                    Container(
                      width: 60.h,
                      height: 60.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            userimage,
                          ),
                        ),
                      ),
                    ),
                    15.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Admin",
                          style: txtstyleblue17,
                        ),
                        5.verticalSpace,
                        Text(
                          DateFormat(
                            "MMM dd yyyy",
                          ).format(
                            DateTime.now(),
                          ),
                          style: textroboto12,
                        ),
                      ],
                    )
                  ],
                ),
                15.verticalSpace,
                Container(
                  width: 0.9.sw,
                  height: 250.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: whitecolor,
                    image: const DecorationImage(
                      image: AssetImage("assets/images/Rectangle 179@3x.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.r, bottom: 10.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          "assets/images/Group 1435@3x.png",
                          scale: 2.5,
                        ),
                      ],
                    ),
                  ),
                ),
                10.verticalSpace,
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae vulputate velit. Nulla facilisi. Fusce interdum ornare arcu, quis",
                  style: textroboto15,
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
        15.verticalSpace,
      ],
    );
  }
}
