import 'package:_uaw/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class DrawerVideoPlayerSvreen extends StatefulWidget {
  const DrawerVideoPlayerSvreen({super.key});

  @override
  State<DrawerVideoPlayerSvreen> createState() => _DrawerVideoPlayerSvreenState();
}

class _DrawerVideoPlayerSvreenState extends State<DrawerVideoPlayerSvreen> {
  late bool _isPlaying = false;
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.network("https:/uaw-api.thesuitchstaging.com/Uploads/1686147854210-_import_625ba1ef73ca95.13144944_FPpreview.mp4")
          ..initialize().then((_) {
            _videoPlayerController.pause();
            setState(() {
              _isPlaying = false;
            });
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
      _isPlaying ? _videoPlayerController.play() : _videoPlayerController.pause();
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
                "assets/images/Group 1431@3x.png",
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
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
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
                Positioned(
                    child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPlaying = true;
                    });
                    _videoPlayerController.play();
                  },
                  child: !_isPlaying
                      ? Container(
                          width: 90.w,
                          height: 90.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 5.w,
                              color: whitecolor,
                            ),
                            color: Colors.white.withOpacity(0.25),
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: whitecolor,
                            size: 55,
                          ),
                        )
                      : Container(),
                ))
              ],
            ),
            50.verticalSpace,
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
              textAlign: TextAlign.center,
              style: txtstylewhite15opacity,
            ),
            30.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: txtstylewhite15opacity,
                ),
                Container(
                  width: 0.7.sw,
                  height: 10.h,
                  child: VideoProgressIndicator(
                    colors: VideoProgressColors(backgroundColor: Colors.white.withOpacity(0.25), playedColor: Color(0xffEEF6FF)),
                    _videoPlayerController,
                    allowScrubbing: true,
                  ),
                ),
                Text(
                  '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: txtstylewhite15opacity,
                ),
              ],
            ),
            40.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_videoPlayerController.value.isPlaying) {
                          _videoPlayerController.pause();
                        } else {
                          _videoPlayerController.play();
                        }
                      });
                    },
                    child: Container(
                        width: 70.w,
                        height: 70.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: white,
                        ),
                        child: _videoPlayerController.value.isPlaying
                            ? Icon(
                                Icons.pause_rounded,
                                color: bluishshade,
                                size: 40,
                              )
                            : Icon(
                                Icons.play_arrow_rounded,
                                color: bluishshade,
                                size: 40,
                              )

                        // IconButton(
                        //   icon: Icon(
                        //     _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                        //   ),
                        //   onPressed: () {

                        //   },
                        // ),
                        ),
                  ),
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: white,
                    ),
                    child: Image.asset("assets/images/Group 1439@3x.png"),
                  ),
                ],
              ),
            ),
            10.verticalSpace,
          ]),
        ),
      ),
    );
  }
}
