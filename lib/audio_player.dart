import 'package:audioplayers/audioplayers.dart';
// import 'package:audioplayers/audio_cache.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progressed_play_button/flutter_progressed_play_button.dart';

// import 'assets/storke_tower.m4a';

class TourAudio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TourAudioState();
  }
}

class _TourAudioState extends State<TourAudio> {

  _TourAudioState(){
    player = AudioCache(fixedPlayer: aPlayer);
  }
  bool isPlaying = false;
  AudioPlayer aPlayer = AudioPlayer();
  late AudioCache player;

  playLocal() async {
    await player.play('storke_tower.mp3');
  }

  pause() async {
    await aPlayer.stop();
  }

  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(isPlaying ? Icons.play_circle_fill : Icons.play_arrow),
        onPressed: () {
          setState(() {
            if (!isPlaying) {
              playLocal();
            } else {
              pause();
            }
            isPlaying = !isPlaying;
          });
        });
  }
}
