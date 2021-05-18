import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:multimediaplayer/data.dart';

class AudioPlayerOff extends StatefulWidget {
  @override
  _AudioPlayerOffState createState() => _AudioPlayerOffState();
}

class _AudioPlayerOffState extends State<AudioPlayerOff>
    with WidgetsBindingObserver {
  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  Duration _duration = Duration();
  Duration _position = Duration();

  onPlayerError() {
    advancedPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        advancedPlayer.stop();
        // _playerState = AudioPlayerState.STOPPED;
        _duration = Duration(seconds: 0);
        _position = Duration(seconds: 0);
      });
    }).onError((error) => print('error onPlayerError'));
  }

  initPlayer() {
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
    // getDuration();
    advancedPlayer.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    }).onError((error) => print('error duration'));
    // getPosition();
    advancedPlayer.onAudioPositionChanged.listen((Duration p) {
      // print('Current position: $p');
      setState(() => _position = p);
    }).onError((error) => print('error position'));
    // onCompletion();
    advancedPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        if (_songCounter == 6) {
          _songCounter = 1;
        } else {
          ++_songCounter;
        }
        _musicName = localMp3[_songCounter];
      });
      play(url: audioMap[localMp3[_songCounter]]);
      if (advancedPlayer != null) {
        setState(() {
          _songPlaying = true;
        });
      }
      print(_musicName);
    }).onError((error) => print('error Completion'));
  }

  String _musicName = 'Select from list';
  int _songCounter = 1;
  bool _songPlaying = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _musicName = 'Select from list';
    initPlayer();
  }

  @override
  void dispose() {
    if (_songPlaying) {
      advancedPlayer.stop().whenComplete(() => advancedPlayer
          .dispose()
          .catchError((error) => print('error dispose')));
    } else {
      advancedPlayer.dispose().catchError((error) => print('error dispose'));
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      advancedPlayer.stop();
    }
  }

  pause() async {
    int result = await advancedPlayer.pause();
    if (result == 1) {
      print("paused");
    }
  }

  stop() async {
    int result = await advancedPlayer.stop();
    if (result == 1) {
      print("stopped");
    }
  }

  play({String url}) {
    audioCache.play(url);
    print('playing');
  }

  resume() async {
    int result = await advancedPlayer.resume();
    if (result == 1) {
      print("resumed");
    }
  }

  seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
  }

  ListView _myMusicList() {
    return ListView.builder(
      itemCount: localMp3.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.all(1.5),
          decoration: BoxDecoration(
              border:
                  Border.all(style: BorderStyle.solid, color: Colors.blue[900]),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  topRight: Radius.circular(12))),
          child: ListTile(
            onTap: () {
              _songCounter = index + 1;
              stop();
              play(url: audioMap[localMp3[index + 1]]);
              setState(() {
                _musicName = localMp3[index + 1];
                _songPlaying = true;
              });
            },
            title: Text("${localMp3[index + 1]}".replaceAll('.mp3', '')),
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 44,
                minHeight: 44,
                maxWidth: 64,
                maxHeight: 64,
              ),
              child: Container(
                margin: EdgeInsets.all(1.2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/${imageMap[localMp3[index + 1]]}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            trailing: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: localMp3[index + 1] == _musicName
                  ? CircleAvatar(
                      child: IconButton(
                        icon: _songPlaying
                            ? Icon(Icons.pause)
                            : Icon(Icons.play_arrow),
                        color: Colors.white,
                        onPressed: () {
                          _songPlaying ? pause() : resume();
                          setState(() {
                            _songPlaying = _songPlaying ? false : true;
                          });
                        },
                      ),
                      backgroundColor: Colors.indigo.shade800,
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }

  Widget slider() {
    return Slider(
        value: _position.inSeconds.toDouble(),
        activeColor: Colors.white,
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            seekToSecond(value.toInt());
            value = value;
          });
        });
  }

  Widget _myMusicPlayer() {
    return Container(
      alignment: Alignment.center,
      // margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
      padding: EdgeInsets.all(5),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.30,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1.0),
          stops: [0.4, 0.6, 0.8, 1],
          colors: <Color>[
            Colors.deepPurple.shade900,
            Colors.blue.shade900,
            Colors.purple.shade900,
            Colors.indigoAccent.shade700,
            // Colors.black45,
            // Colors.white60,
            // Colors.white54,
            // Colors.black38,
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          // bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(blurRadius: 1.0, spreadRadius: 3.0, color: Colors.black45),
          // BoxShadow(),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          slider(),
          // Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Image
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width * 0.4,
                margin: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_musicName == 'Select from list'
                        ? 'assets/images/music.jpg'
                        : 'assets/images/${imageMap[_musicName]}'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1.0,
                      spreadRadius: 3.0,
                      color: Colors.white30,
                    ),
                    // BoxShadow(),
                  ],
                ),
              ),
              // SizedBox(width: 20),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Timer
                      _musicName == "Select from list"
                          ? SizedBox()
                          : Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                margin: EdgeInsets.only(right: 15.0),
                                child: Text(
                                  _position.toString().split('.').first +
                                      " / " +
                                      _duration.toString().split('.').first,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).textScaleFactor *
                                            16,
                                  ),
                                ),
                              ),
                            ),
                      // Control Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // rewind
                          IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.fast_rewind, size: 50),
                            onPressed: () {
                              // print('rewind ...');
                              if (_songCounter == 1) {
                                _songCounter = 6;
                              } else {
                                _songCounter = _songCounter > 1
                                    ? _songCounter - 1
                                    : _songCounter;
                              }
                              stop();
                              setState(() {
                                _musicName = localMp3[_songCounter];
                                _songPlaying = true;
                              });
                              play(url: audioMap[_musicName]);
                            },
                          ),
                          // play-pause
                          IconButton(
                            color: Colors.white,
                            icon: Icon(
                                _songPlaying
                                    ? Icons.pause_circle_outline
                                    : Icons.play_circle_outline,
                                size: 50),
                            onPressed: () {
                              _songPlaying ? pause() : resume();
                              setState(() {
                                _songPlaying = _songPlaying ? false : true;
                                _musicName = localMp3[_songCounter];
                              });
                            },
                          ),
                          // stop
                          IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.stop_circle_outlined, size: 50),
                            onPressed: () {
                              stop();
                              setState(() {
                                _songPlaying = false;
                                _musicName = 'Select from list';
                                _duration = Duration();
                                _position = Duration();
                              });
                            },
                          ),
                          // forward
                          IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.fast_forward, size: 50),
                            onPressed: () {
                              // print('forward ...');
                              if (_songCounter == 6) {
                                _songCounter = 1;
                              } else {
                                _songCounter = _songCounter < 6
                                    ? _songCounter + 1
                                    : _songCounter;
                              }
                              stop();
                              setState(() {
                                _musicName = localMp3[_songCounter];
                                _songPlaying = true;
                              });
                              play(url: audioMap[_musicName]);
                            },
                          ),
                        ],
                      ),
                      // Song Name : _musicName
                      Container(
                        margin: EdgeInsets.only(top: 15, left: 15),
                        child: Text(
                          '$_musicName',
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.33),
          child: _myMusicList(),
        ),
        Align(child: _myMusicPlayer(), alignment: Alignment.bottomCenter),
      ],
    );
  }
}
