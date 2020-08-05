import 'package:audioplayers/audioplayers.dart';
import "package:flutter/material.dart";
import 'package:assets_audio_player/assets_audio_player.dart';

void main() => runApp(Mymusic());

class Mymusic extends StatefulWidget {
  @override
  _MymusicState createState() => _MymusicState();
}

class _MymusicState extends State<Mymusic> {
  bool playingButton = false;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer audioPlayer;
  AssetsAudioPlayer assetsAudioPlayer;

  @override
  void initState() {
    super.initState();
    playSongs();
  }

  void playSongs() {
    audioPlayer = AudioPlayer();
    audioPlayer.onDurationChanged.listen((Duration dd) {
      setState(() {
        _duration = dd;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((Duration dd) {
      setState(() {
        _position = dd;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My first music app",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.shade300,
          title: Text("Music App"),
        ),
        body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://www.lyricstake.com/wp-content/uploads/2019/02/Duniya-Lyrics-from-Luka-Chuppi.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                  color: Colors.lightBlue,
                  border: Border.all(color: Colors.red.shade200, width: 5.0),
                ),
              ),
              Padding(padding: EdgeInsets.all(15.0)),
              slider(),
              Padding(padding: EdgeInsets.all(20.0)),
              Card(
                color: Colors.red.shade100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                        iconSize: 30,
                        icon: Icon(Icons.fast_rewind),
                        onPressed: () {
                          var fastRewind =
                              audioPlayer.seek(Duration(seconds: -10));
                          print(fastRewind);
                        }),
                    IconButton(
                        icon: Icon(
                            playingButton ? Icons.pause : Icons.play_arrow),
                        iconSize: 60,
                        color: Colors.black,
                        onPressed: () async {
                          if (playingButton == false) {
                            var url =
                                "https://raw.githubusercontent.com/niteshrathore123/songs/master/duniya.mp3";
                            var playSong = await audioPlayer.play(url);
                            print(playSong);

                            setState(() {
                              playingButton = true;
                            });
                          } else {
                            var r = await audioPlayer.pause();
                            print(r);
                            setState(() {
                              playingButton = false;
                            });
                          }
                        }),
                    IconButton(
                        iconSize: 30,
                        icon: Icon(Icons.fast_forward),
                        onPressed: () async {
                          var fastForward =
                              audioPlayer.seek(Duration(seconds: 10));
                          print(fastForward);
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget slider() {
    return Slider(
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        activeColor: Colors.pink.shade400,
        inactiveColor: Colors.grey,
        onChanged: (double value) {
          setState(() {
            audioPlayer.seek(Duration(seconds: value.toInt()));
            value = value;
          });
        });
  }
}
