import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class DrawerVideoPlayer extends StatefulWidget {
  final videoFilePath;
  final details;

  DrawerVideoPlayer({
    required this.videoFilePath,
    required this.details,
  });

  @override
  State<DrawerVideoPlayer> createState() => _DrawerVideoPlayerState();
}

class _DrawerVideoPlayerState extends State<DrawerVideoPlayer> {
  ChewieController? _chewieController;

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
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true,
      );
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
      ),
      body: Column(
        children: [
          Expanded(
            child: _chewieController != null
                ? Chewie(
                    controller: _chewieController!,
                  )
                : Center(child: CircularProgressIndicator()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _fastRewind,
                icon: Icon(Icons.fast_rewind),
              ),
              IconButton(
                onPressed: _fastForward,
                icon: Icon(Icons.fast_forward),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
