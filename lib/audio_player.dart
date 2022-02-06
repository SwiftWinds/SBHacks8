import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progressed_play_button/flutter_progressed_play_button.dart';

// import 'recordings/storke_tower.m4a';

class TourAudio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TourAudioState();
  }
}

class _TourAudioState extends State<TourAudio> {
  bool isPlaying = false;
  AudioPlayer player = AudioPlayer();

  playLocal() async {
    int result = await player.play('recordings/storke_tower.mp3',
        isLocal: true);
  }

  pause() async {
    int result = await player.pause();
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
