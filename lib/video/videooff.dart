import 'package:flutter/material.dart';
import 'package:multimediaplayer/data.dart';
import 'package:multimediaplayer/video/player.dart';

class VideoPlayerOff extends StatefulWidget {
  @override
  _VideoPlayerOffState createState() => _VideoPlayerOffState();
}

class _VideoPlayerOffState extends State<VideoPlayerOff> {
  @override
  Widget build(BuildContext context) {
    List<String> vidList = videoMap.keys.toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          elevation: 3.0,
          child: ListTile(
            title: Text(
              vidList[index].replaceAll('.mp4', ''),
              textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.25,
            ),
            leading: Image.asset('assets/images/' +
                imageMap[vidList[index].replaceAll('.mp4', '.mp3')]),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => VideoPlayerRoute(
                  name: vidList[index],
                  url: videoMap[vidList[index]],
                  isAsset: true,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: videoMap.length,
    );
  }
}
