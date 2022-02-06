import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class TourAudioButton extends StatefulWidget {
  const TourAudioButton(this.audioFileURL, {Key? key}) : super(key: key);

  final String audioFileURL;

  @override
  State<StatefulWidget> createState() => _TourAudioButtonState();
}

class _TourAudioButtonState extends State<TourAudioButton> {
  _TourAudioButtonState(){
    player = AudioCache(fixedPlayer: aPlayer);
  }
  bool isPlaying = false;
  AudioPlayer aPlayer = AudioPlayer();
  late AudioCache player;

  playLocal(String url) async {
    await player.play(url);
  }

  pause() async {
    await aPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isPlaying ? Icons.play_circle_fill : Icons.play_arrow),
      iconSize: 60,
      onPressed: () {
        setState(() {
          if (!isPlaying) {
            playLocal(widget.audioFileURL);
          } else {
            pause();
          }
          isPlaying = !isPlaying;
        });
      }
    );
  }
}
