import 'package:flutter/material.dart';
import 'package:multimediaplayer/audio/audiooff.dart';
import 'package:multimediaplayer/audio/audioon.dart';
import 'package:multimediaplayer/video/videoon.dart';
import 'package:multimediaplayer/video/videooff.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _screen = 0;
  Key _drawer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  testBody(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline4,
          ),
          CircleAvatar(
            backgroundColor: Colors.redAccent,
            child: IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: _incrementCounter,
            ),
          ),
        ],
      ),
    );
  }

  _setBody(BuildContext context) {
    switch (_screen) {
      case 1:
        return AudioPlayerOff();
        break;
      case 2:
        return AudioPlayerOn();
        break;
      case 3:
        return VideoPlayerOff();
        break;
      case 4:
        return VideoPlayerOn();
        break;
      default:
        return testBody(context);
    }
  }

  String _setAppBar() {
    switch (_screen) {
      case 1:
        return "Offline Audio Player";
        break;
      case 2:
        return "Online Audio Player";
        break;
      case 3:
        return "Offline Video Player";
        break;
      case 4:
        return "Online Video Player";
        break;
      default:
        return "Media Player";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_setAppBar()),
        backgroundColor: Colors.blue.shade900,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20))),
        shadowColor: Colors.blue.shade900,
      ),
      body: _setBody(context),
      drawer: Drawer(
        key: _drawer,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              curve: Curves.easeOutQuart,
              child: Image(
                  image: AssetImage("assets/images/drawer.jpg"),
                  fit: BoxFit.fill),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45, width: 1),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(40, 20))),
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: ListTile(
                leading: Icon(Icons.library_music),
                title: Text("Audio Player",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).textScaleFactor * 18,
                      // fontWeight: FontWeight.bold,
                    )),
              ),
              children: <Widget>[
                Card(
                    child: ListTile(
                  title: Text("Play music offline"),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _screen = 1;
                    });
                  },
                )),
                Card(
                    child: ListTile(
                  title: Text("Play music online"),
                  // trailing: Icon(Icons.music_note_outlined),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _screen = 2;
                    });
                  },
                )),
              ],
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: ListTile(
                leading: Icon(Icons.video_collection_rounded),
                title: Text("Video Player",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).textScaleFactor * 18,
                      // fontWeight: FontWeight.bold,
                    )),
              ),
              children: <Widget>[
                Card(
                    child: ListTile(
                  title: Text("Go offline"),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _screen = 3;
                    });
                  },
                )),
                Card(
                    child: ListTile(
                  title: Text("Go online"),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _screen = 4;
                    });
                  },
                )),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                title: Text('Main Menu'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _screen = 0;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
