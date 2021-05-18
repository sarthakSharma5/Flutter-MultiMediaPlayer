import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multimediaplayer/video/videoon.dart';
import 'package:multimediaplayer/video/videooff.dart';

class VideoView extends StatefulWidget {
  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Video Player',
            style: GoogleFonts.montserrat(),
            textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.35,
          ),
          backgroundColor: Colors.blue.shade900,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(20))),
          shadowColor: Colors.blue.shade900,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Offine'),
              Tab(text: 'Online'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            VideoPlayerOff(),
            VideoPlayerOn(),
          ],
        ),
      ),
    );
  }
}
