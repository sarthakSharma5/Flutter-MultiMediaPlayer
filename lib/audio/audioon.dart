import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:multimediaplayer/data.dart';

class AudioPlayerOn extends StatefulWidget {
  @override
  _AudioPlayerOnState createState() => _AudioPlayerOnState();
}

class _AudioPlayerOnState extends State<AudioPlayerOn> {
  String _songToPlay, _lastSong;

  AudioPlayer advancedPlayer;
  Duration _duration = Duration();
  Duration _position = Duration();

  bool _songPlaying = false;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  onPlayerError() {
    advancedPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        advancedPlayer.stop();
        // _playerState = AudioPlayerState.STOPPED;
        _duration = Duration(seconds: 0);
        _position = Duration(seconds: 0);
      });
    });
  }

  initPlayer() {
    advancedPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    // getDuration();
    advancedPlayer.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });
    // getPosition();
    advancedPlayer.onAudioPositionChanged.listen((Duration p) {
      // print('Current position: $p');
      setState(() => _position = p);
    });
    // onCompletion();
    advancedPlayer.onPlayerCompletion.listen((event) {
      stop();
      if (advancedPlayer != null) {
        setState(() {
          _position = _duration;
          _songPlaying = false;
        });
      }
    });
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

  play({String url}) async {
    int result = await advancedPlayer
        .play(url)
        .catchError((error) => print('Error:\n' + error.toString()));
    if (result == 1) {
      print('playing');
    }
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

  @override
  void dispose() {
    if (_songPlaying) {
      advancedPlayer.stop().whenComplete(() => advancedPlayer
          .dispose()
          .catchError((error) => print('error dispose')));
    } else {
      advancedPlayer.dispose().catchError((error) => print('error dispose'));
    }
    super.dispose();
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
                    image: AssetImage(_songToPlay != null
                        ? 'assets/images/${imageMap[_songToPlay + '.mp3']}'
                        : 'assets/images/music.jpg'),
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
                      _songToPlay == null || _songToPlay == ""
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
                              print('rewind ...');
                              stop();
                              if (_lastSong != null) {
                                var temp = _lastSong;
                                _lastSong = _songToPlay;
                                setState(() {
                                  _songToPlay = temp;
                                  _position = Duration();
                                  _duration = Duration();
                                });
                              }
                              if (_songToPlay != null || _songToPlay != '') {
                                play(url: songUrl[_songToPlay + '.mp3']);
                                setState(() {
                                  _songPlaying = true;
                                });
                              }
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
                                _songToPlay = null;
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
                              print('forward ...');
                              stop();
                              if (_lastSong != null) {
                                var temp = _lastSong;
                                _lastSong = _songToPlay;
                                setState(() {
                                  _songToPlay = temp;
                                  _position = Duration();
                                  _duration = Duration();
                                });
                              }
                              if (_songToPlay != null || _songToPlay != '') {
                                play(url: songUrl[_songToPlay + '.mp3']);
                                setState(() {
                                  _songPlaying = true;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      _songToPlay == null
                          ? SizedBox()
                          : Container(
                              margin: EdgeInsets.only(top: 15, left: 15),
                              child: Text(
                                '$_songToPlay',
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          16,
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

  Widget _buildMusicList() {
    var sNames = songUrl.keys;
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black38, width: 1)),
            child: ListTile(
              title: Text(sNames.elementAt(index).replaceAll('.mp3', '')),
              onTap: () {
                stop();
                play(url: songUrl[sNames.elementAt(index)]);
                setState(() {
                  _position = Duration();
                  _duration = Duration();
                  _songToPlay = sNames.elementAt(index).replaceAll('.mp3', '');
                  _songPlaying = true;
                });
              },
              trailing:
                  _songToPlay == sNames.elementAt(index).replaceAll('.mp3', '')
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
              leading: Container(
                margin: EdgeInsets.all(0.5),
                child: Image(
                  image: AssetImage(
                    'assets/images/${imageMap[localMp3[index + 1]]}',
                  ),
                ),
              ),
            ));
      },
      itemCount: songUrl.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(
              5, 5, 5, MediaQuery.of(context).size.height * 0.33),
          child: _buildMusicList(),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black45),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _myMusicPlayer(),
        ),
      ],
    );
  }
}
