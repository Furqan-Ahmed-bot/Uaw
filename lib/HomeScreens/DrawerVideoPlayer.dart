// import 'package:_uaw/Helpers.dart';
// import 'package:_uaw/HomeScreens/home.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:video_player/video_player.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;

// class DrawerVideoPlayerSvreen extends StatefulWidget {
//   final Videofilepath;
//   final details;

//   DrawerVideoPlayerSvreen({
//     super.key,
//     this.details,
//     this.Videofilepath,
//   });

//   @override
//   State<DrawerVideoPlayerSvreen> createState() => _DrawerVideoPlayerSvreenState();
// }

// class _DrawerVideoPlayerSvreenState extends State<DrawerVideoPlayerSvreen> {
//   late bool _isPlaying = false;
//   VideoPlayerController? _videoPlayerController;
//   bool _isControllerInitialized = false;
//   int _currentVideoIndex = 0;
//   double _seekAmount = 3.0;
//   Duration _position = Duration();
//   bool _isInitialized = false;
//   File? videoFilePath;
//   @override
//   void initState() {
//     super.initState();
//     _isInitialized = false;
//     _initializeVideoPlayer();

//     setState(() {
//       _isPlaying = false;
//     });

//     // }
//   }

//   Future<void> _initializeVideoPlayer() async {
//     // String NewURL = widget.vurl.replaceFirst("https:/", "https://");
//     // File videoFile = await DefaultCacheManager().getSingleFile(NewURL);
//     _videoPlayerController = VideoPlayerController.file(widget.Videofilepath);
//     await _videoPlayerController!.initialize();
//     _videoPlayerController!.play();
//     _videoPlayerController!.pause();
//     setState(() {
//       _isInitialized = true;
//       _isControllerInitialized = true;
//       _videoPlayerController!.pause();
//     });
//     _videoPlayerController!.addListener(_handlePositionUpdate);

//     Duration durationOfVideo = _videoPlayerController!.value.duration;
//   }

//   void _handlePositionUpdate() {
//     setState(() {
//       _position = _videoPlayerController!.value.position;
//     });
//   }

//   getVideoPosition() {
//     var duration = Duration(seconds: _videoPlayerController!.value.position.inSeconds.round());
//     return [duration.inMinutes, duration.inSeconds].map((seg) => seg.remainder(60).toString().padLeft(2, '0')).join(':');
//   }

//   @override
//   void dispose() {
//     _videoPlayerController!.dispose();
//     DefaultCacheManager().emptyCache();
//     super.dispose();
//   }

//   void _playPause() {
//     setState(() {
//       _isPlaying ? _videoPlayerController!.play() : _videoPlayerController!.pause();
//       _isPlaying = !_isPlaying;
//     });
//   }

//   void _fastForward() {
//     // Get the current position and add the seek amount
//     var currentPosition = _videoPlayerController!.value.position;
//     var seekPosition = currentPosition + Duration(seconds: _seekAmount.toInt());

//     // Check if the seek position is within the video duration
//     if (seekPosition > _videoPlayerController!.value.duration) {
//       seekPosition = _videoPlayerController!.value.duration;
//     }

//     // Seek to the new position
//     _videoPlayerController!.seekTo(seekPosition);
//   }

//   void _fastRewind() {
//     // Get the current position and subtract the seek amount
//     var currentPosition = _videoPlayerController!.value.position;
//     var seekPosition = currentPosition - Duration(seconds: _seekAmount.toInt());

//     // Check if the seek position is within the video duration
//     if (seekPosition < Duration.zero) {
//       seekPosition = Duration.zero;
//     }

//     // Seek to the new position
//     _videoPlayerController!.seekTo(seekPosition);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Duration duration = _videoPlayerController!.value.duration ?? Duration.zero;
//     Duration position = _videoPlayerController!.value.position ?? Duration.zero;
//     return Container(
//       width: 1.sw,
//       height: 1.sh,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage("assets/images/Mask Group 3@3x.png"),
//           fit: BoxFit.fill,
//         ),
//       ),
//       child: Scaffold(
//           backgroundColor: transparentcolor,
//           appBar: AppBar(
//             backgroundColor: transparentcolor,
//             elevation: 0,
//             leadingWidth: 70,
//             leading: Center(
//               child: GestureDetector(
//                 onTap: () {
//                   Get.back();
//                 },
//                 child: Image.asset(
//                   "assets/images/Group 1431@3x.png",
//                   scale: 2.5,
//                 ),
//               ),
//             ),
//             title: Hero(
//               tag: "Video",
//               child: Material(
//                 type: MaterialType.transparency,
//                 child: Text(
//                   "VIDEOS",
//                   style: labeltxtwhite18,
//                 ),
//               ),
//             ),
//             centerTitle: true,
//           ),
//           body: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.r),
//             child: Column(children: [
//               Stack(
//                 clipBehavior: Clip.none,
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     width: 1.sw,
//                     height: 524.h,
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10.0),
//                         child: AspectRatio(
//                           aspectRatio: _videoPlayerController!.value.aspectRatio,
//                           child: VideoPlayer(
//                                   _videoPlayerController!,
//                                 ),

//                         ),),
//                   ),
//                   Positioned(
//                       child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _isPlaying = true;
//                       });
//                       _videoPlayerController!.play();
//                     },
//                     child: !_isPlaying
//                         ? Container(
//                             width: 90.w,
//                             height: 90.w,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 width: 5.w,
//                                 color: whitecolor,
//                               ),
//                               color: Colors.white.withOpacity(0.25),
//                             ),
//                             child: Icon(
//                               Icons.play_arrow_rounded,
//                               color: whitecolor,
//                               size: 55,
//                             ),
//                           )
//                         : Container(),
//                   ))
//                 ],
//               ),
//               50.verticalSpace,
//               widget.details == null
//                   ? Text("")
//                   : Text(
//                       widget.details,
//                       textAlign: TextAlign.center,
//                       style: txtstylewhite15opacity,
//                     ),
//               30.verticalSpace,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     '${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}',
//                     style: txtstylewhite15opacity,
//                   ),
//                   Container(
//                     width: 0.7.sw,
//                     height: 10.h,
//                     child: VideoProgressIndicator(
//                       colors: VideoProgressColors(backgroundColor: Colors.white.withOpacity(0.25), playedColor: Color(0xffEEF6FF)),
//                       _videoPlayerController!,
//                       allowScrubbing: true,
//                     ),
//                   ),
//                   Text(
//                     '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
//                     style: txtstylewhite15opacity,
//                   ),
//                 ],
//               ),
//               40.verticalSpace,
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 50.r),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         _fastRewind();
//                       },
//                       child: Container(
//                         width: 48.w,
//                         height: 48.h,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: white,
//                         ),
//                         child: Image.asset("assets/images/Group 1437@3x.png"),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           if (_videoPlayerController!.value.isPlaying) {
//                             _videoPlayerController!.pause();
//                           } else {
//                             _videoPlayerController!.play();
//                           }
//                         });
//                       },
//                       child: Container(
//                           width: 70.w,
//                           height: 70.h,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: white,
//                           ),
//                           child: _videoPlayerController!.value.isPlaying
//                               ? Icon(
//                                   Icons.pause_rounded,
//                                   color: bluishshade,
//                                   size: 40,
//                                 )
//                               : Icon(
//                                   Icons.play_arrow_rounded,
//                                   color: bluishshade,
//                                   size: 40,
//                                 )

//                           // IconButton(
//                           //   icon: Icon(
//                           //     _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                           //   ),
//                           //   onPressed: () {

//                           //   },
//                           // ),
//                           ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         _fastForward();
//                       },
//                       child: Container(
//                         width: 48.w,
//                         height: 48.h,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: white,
//                         ),
//                         child: Image.asset("assets/images/Group 1439@3x.png"),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               10.verticalSpace,
//             ]),
//           )),
//     );
//   }
// }
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

import '../Helpers.dart';

class DrawerVideoPlayerSvreen extends StatefulWidget {
  final videoFilePath;
  final vurl;
  final details;

  DrawerVideoPlayerSvreen({
    super.key,
    this.details,
    this.vurl,
    this.videoFilePath,
  });

  @override
  State<DrawerVideoPlayerSvreen> createState() => _DrawerVideoPlayerSvreenState();
}

class _DrawerVideoPlayerSvreenState extends State<DrawerVideoPlayerSvreen> {
  ChewieController? _chewieController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _chewieController!.dispose();
    super.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    final videoPlayerController = VideoPlayerController.network(widget.videoFilePath);

    await videoPlayerController.initialize();

    setState(() {
      _chewieController = ChewieController(
        placeholder: Container(
          color: Colors.black,
        ),
        aspectRatio: videoPlayerController.value.aspectRatio,
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: true,
      );
    });
    _chewieController!.videoPlayerController.addListener(_videoPlayerListener);
  }

  void _videoPlayerListener() {
    final isPlaying = _chewieController!.videoPlayerController.value.isPlaying;
    if (_isPlaying != isPlaying) {
      setState(() {
        _isPlaying = isPlaying;
      });
    }
  }

  void _fastForward() {
    final currentPosition = _chewieController!.videoPlayerController.value.position;
    final seekPosition = currentPosition + Duration(seconds: 10);

    if (seekPosition > _chewieController!.videoPlayerController.value.duration) {
      _chewieController!.seekTo(_chewieController!.videoPlayerController.value.duration);
    } else {
      _chewieController!.seekTo(seekPosition);
    }
  }

  void _fastRewind() {
    final currentPosition = _chewieController!.videoPlayerController.value.position;
    final seekPosition = currentPosition - Duration(seconds: 10);

    if (seekPosition < Duration.zero) {
      _chewieController!.seekTo(Duration.zero);
    } else {
      _chewieController!.seekTo(seekPosition);
    }
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _chewieController!.play();
      } else {
        _chewieController!.pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 1.sw,
                    height: 524.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: _chewieController != null
                          ? Chewie(
                              controller: _chewieController!,
                            )
                          : Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  // Positioned(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       setState(() {
                  //         _isPlaying = true;
                  //       });
                  //       _chewieController.play();
                  //     },
                  //     child: Container(
                  //       width: 1.sw,
                  //       height: 524.h,
                  //       child: !_isPlaying
                  //           ? Icon(
                  //               Icons.play_arrow,
                  //               color: Colors.white,
                  //               size: 80.w,
                  //             )
                  //           : SizedBox.shrink(),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 15.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      widget.details != null
                          ? Text(
                              widget.details,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            )
                          : Text("Description"),
                      50.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _fastRewind();
                              },
                              child: Container(
                                width: 48.w,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: white,
                                ),
                                child: Image.asset("assets/images/Group 1437@3x.png"),
                              ),
                            ),
                            Container(
                              width: 70.w,
                              height: 70.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: white,
                              ),
                              child: IconButton(
                                onPressed: _togglePlayPause,
                                icon: _isPlaying
                                    ? Icon(
                                        Icons.pause,
                                        color: bluishshade,
                                        size: 40,
                                      )
                                    : Icon(
                                        Icons.play_arrow,
                                        color: bluishshade,
                                        size: 40,
                                      ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _fastForward();
                              },
                              child: Container(
                                width: 48.w,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: white,
                                ),
                                child: Image.asset("assets/images/Group 1439@3x.png"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
