import 'package:flutter/material.dart';
import 'package:multimediaplayer/video/player.dart';
import 'package:multimediaplayer/data.dart';

class VideoPlayerOn extends StatefulWidget {
  @override
  _VideoPlayerOnState createState() => _VideoPlayerOnState();
}

class _VideoPlayerOnState extends State<VideoPlayerOn> {
  @override
  Widget build(BuildContext context) {
    List<String> vidList = videoUrl.keys.toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          elevation: 3.0,
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              vidList[index].replaceAll('.mp4', ''),
              textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.25,
            ),
            leading: Image.asset('assets/images/drawer.jpg'),
            trailing: Icon(Icons.play_circle_outline),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => VideoPlayerRoute(
                  name: vidList[index],
                  isAsset: false,
                  url: videoUrl[vidList[index]],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: videoUrl.length,
    );
  }
}
