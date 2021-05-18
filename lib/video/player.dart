import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerRoute extends StatefulWidget {
  VideoPlayerRoute(
      {@required this.name, @required this.url, this.isAsset = true, Key key})
      : super(key: key);
  final String name;
  final String url;
  final bool isAsset;

  @override
  _VideoPlayerRouteState createState() => _VideoPlayerRouteState();
}

class _VideoPlayerRouteState extends State<VideoPlayerRoute> {
  VideoPlayerController _controller;
  ChewieController _chewieController;

  Future<void> initializePlayer() async {
    if (widget.isAsset) {
      _controller = VideoPlayerController.asset(widget.url);
      // print('asset');
    } else {
      _controller = VideoPlayerController.network(widget.url);
      // print('network');
    }

    await Future.wait([_controller.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: true,
      fullScreenByDefault: true,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    // _chewieController?.pause();
    _controller.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_chewieController != null && _chewieController.isPlaying) {
          _chewieController.pause();
        }
        return new Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            widget.name.replaceAll('.mp4', ''),
            style: GoogleFonts.philosopher(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: _chewieController != null &&
                  _chewieController.videoPlayerController.value.initialized
              ? Chewie(
                  controller: _chewieController,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('Loading'),
                  ],
                ),
        ),
      ),
    );
  }
}
