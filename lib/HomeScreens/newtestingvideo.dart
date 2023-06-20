import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class NewtestingVideoScreen extends StatefulWidget {
  final vurl;
  final details;
  NewtestingVideoScreen({
    super.key,
    this.vurl,
    this.details,
  });

  @override
  State<NewtestingVideoScreen> createState() => _NewtestingVideoScreenState();
}

class _NewtestingVideoScreenState extends State<NewtestingVideoScreen> {
  late VideoPlayerController _controller;
  late bool _isInitialized;

  @override
  void initState() {
    super.initState();
    _isInitialized = false;
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    String videoUrl = widget.vurl;
    File videoFile = await DefaultCacheManager().getSingleFile(videoUrl);
    _controller = VideoPlayerController.file(videoFile);
    await _controller.initialize();
    setState(() {
      _isInitialized = true;
      _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: _isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(),
      ),
    );
    Container();
  }
}
