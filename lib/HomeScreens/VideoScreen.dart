import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VidePalayerScreen extends StatefulWidget {
  const VidePalayerScreen({super.key});

  @override
  State<VidePalayerScreen> createState() => _VidePalayerScreenState();
}

class _VidePalayerScreenState extends State<VidePalayerScreen> {
  bool _isPlaying = false;
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset('assets/images/video.mp4')
      ..addListener(() {
        setState(() {});
      })
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
    Duration durationOfVideo = _videoPlayerController.value.duration;
  }

  getVideoPosition() {
    var duration = Duration(milliseconds: _videoPlayerController.value.position.inMilliseconds.round());
    return [duration.inMinutes, duration.inSeconds].map((seg) => seg.remainder(60).toString().padLeft(2, '0')).join(':');
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _playPause() {
    setState(() {
      _isPlaying ? _videoPlayerController.pause() : _videoPlayerController.play();
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Duration duration = _videoPlayerController.value.duration;
    final Duration position = _videoPlayerController.value.position;
    return Container(
      width: 1.sw,
      height: 1.sh,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Mask Group 3@3x.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: transparentcolor,
        appBar: AppBar(
          backgroundColor: transparentcolor,
          elevation: 0,
          leadingWidth: 70,
          leading: Center(
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                "assets/images/Group 1430@3x.png",
                scale: 2.5,
              ),
            ),
          ),
          title: Hero(
            tag: "Video",
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                "VIDEOS",
                style: labeltxtwhite18,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Column(children: [
            Container(
              width: 1.sw,
              height: 524.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: AspectRatio(
                  aspectRatio: _videoPlayerController!.value.aspectRatio,
                  child: VideoPlayer(
                    _videoPlayerController,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: white,
                  ),
                  child: Image.asset("assets/images/Group 1437@3x.png"),
                ),
                ElevatedButton(
                    onPressed: () {
                      _videoPlayerController.pause();
                    },
                    child: Icon(Icons.pause)),
                Padding(padding: EdgeInsets.all(2)),
                ElevatedButton(
                    onPressed: () {
                      _videoPlayerController.play();
                    },
                    child: Icon(Icons.play_arrow))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}'),
                Text('${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}'),
              ],
            ),
            VideoProgressIndicator(
              _videoPlayerController,
              allowScrubbing: true,
            ),
            10.verticalSpace,
          ]),
        ),
      ),
    );
  }
}
