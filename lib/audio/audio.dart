import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multimediaplayer/audio/audiooff.dart';
import 'package:multimediaplayer/audio/audioon.dart';

class AudioView extends StatefulWidget {
  @override
  _AudioViewState createState() => _AudioViewState();
}

class _AudioViewState extends State<AudioView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Music Player',
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
              Tab(text: 'Offline'),
              Tab(text: 'Online'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AudioPlayerOff(),
            AudioPlayerOn(),
          ],
        ),
        // bottomSheet: Container(
        //   height: MediaQuery.of(context).size.height * 0.3,
        // ),
      ),
    );
  }
}
