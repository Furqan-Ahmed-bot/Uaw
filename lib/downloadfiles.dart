import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class DownloadingDialogFile extends StatefulWidget {
  final url;

  const DownloadingDialogFile({Key? key, @required this.url}) : super(key: key);

  @override
  _DownloadingDialogFileState createState() => _DownloadingDialogFileState();
}

class _DownloadingDialogFileState extends State<DownloadingDialogFile> {
  Dio dio = Dio();
  double progress = 0.0;
  String? filePath;

  Future<void> startDownloading() async {
    String dir = (await getExternalStorageDirectory())!.path; // Use getExternalStorageDirectory() instead of getApplicationDocumentsDirectory()
    String fileName = widget.url.split('/').last;
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
    OpenFile.open(filePath!);
  }

  @override
  void initState() {
    super.initState();
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
