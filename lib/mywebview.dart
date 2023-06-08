// // import 'package:flutter/material.dart';
// // import 'package:webview_flutter/webview_flutter.dart';
// // class WebViewContainer extends StatefulWidget {
// //   final url;
// //   WebViewContainer(this.url);
// //   @override
// //   createState() => _WebViewContainerState(this.url);
// // }
// // class _WebViewContainerState extends State<WebViewContainer> {
// //   var _url;
// //   final _key = UniqueKey();
// //   _WebViewContainerState(this._url);
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(),
// //         body: Column(
// //           children: [
// //             Expanded(
// //                 child: WebView(
// //                     key: _key,
// //                     javascriptMode: JavascriptMode.unrestricted,
// //                     initialUrl: _url))
// //           ],
// //         ));
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewContainer extends StatefulWidget {
//   final url;
//   WebViewContainer({super.key, this.url});

//   @override
//   State<WebViewContainer> createState() => _WebViewContainerState();
// }

// class _WebViewContainerState extends State<WebViewContainer> {
//   var controller = WebViewController()
//     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//     ..setBackgroundColor(const Color(0x00000000))
//     ..setNavigationDelegate(
//       NavigationDelegate(
//         onPageStarted: (String url) {},
//         onPageFinished: (String url) {},
//         onWebResourceError: (WebResourceError error) {},
//         onNavigationRequest: (NavigationRequest request) {
//           if (request.url.startsWith('https://www.youtube.com/')) {
//             return NavigationDecision.prevent;
//           }
//           return NavigationDecision.navigate;
//         },
//       ),
//     )
//     ..loadRequest(Uri.parse('https:/uaw-api.thesuitchstaging.com/Uploads/1686158900458-sample2.txt'));

//   final _key = UniqueKey();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: WebViewWidget(controller: controller),
//     );
//   }
// }


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class DownloadingDialogFiless extends StatefulWidget {
  final url;

  const DownloadingDialogFiless({Key? key, @required this.url}) : super(key: key);

  @override
  _DownloadingDialogFilessState createState() => _DownloadingDialogFilessState();
}

class _DownloadingDialogFilessState extends State<DownloadingDialogFiless> {
  String myurls = 'https://uaw-api.thesuitchstaging.com/Uploads/1686232844877-1685717967845-dummy.docx';
  Dio dio = Dio();
  double progress = 0.0;
  String? filePath;

  Future<void> startDownloading() async {
    String dir = (await getExternalStorageDirectory())!.path; // Use getExternalStorageDirectory() instead of getApplicationDocumentsDirectory()
    String fileName = myurls.split('/').last;
    String fullPath = '$dir/Download/$fileName';
    print(fullPath);
    // Specify the Download folder

    await dio.download(
      widget.url,
      fullPath,
      // onReceiveProgress: (receivedBytes, totalBytes) {
      //   setState(() {
      //     progress = receivedBytes / totalBytes;
      //   });
      // },
    );

    setState(() {
      filePath = fullPath;
    });
    Get.back();
    OpenFilex.open(filePath!);
  }

  @override
  void initState() {
    
    startDownloading();
  }

  @override
  Widget build(BuildContext context) {
    String downloadingProgress = (progress * 100).toStringAsFixed(0);

    return AlertDialog(
      backgroundColor: Colors.black38,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircularProgressIndicator.adaptive(),
          SizedBox(height: 20),
          Text(
            "Opeining",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}

