import 'package:discovar/tour_audio_button.dart';
import 'package:flutter/material.dart';

import 'model/tour_point.dart';

class AudioInformation extends StatefulWidget {
  const AudioInformation({Key? key, required this.tourPoint})
      : super(key: key);
  final TourPoint tourPoint;

  @override
  State<AudioInformation> createState() => _AudioInformationState();
}

class _AudioInformationState extends State<AudioInformation> {
  bool hearted = false;

  @override
  Widget build(BuildContext context) {
    var row1 = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: TourAudioButton(widget.tourPoint.audioPath)
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(widget.tourPoint.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: FloatingActionButton(
            child: const Icon(Icons.favorite),
            backgroundColor: hearted ? const Color(0xFFA28AD2) : const Color(0xFFFFFFFF),
            foregroundColor: hearted ? const Color(0xFFFFFFFF) : const Color(0xAAAAAAAA),
            onPressed: () {
              setState(() {
                hearted = !hearted;
              });
            },
          )
        ),
      ],
    );

    return Column(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: row1
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(15, 45, 15, 40),
        child: Expanded(
          child: SingleChildScrollView(
            child: Text(widget.tourPoint.description)
          )
        ),
      )
    ]);
  }
}
