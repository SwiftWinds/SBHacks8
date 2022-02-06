import 'package:flutter/material.dart';

import '../model/tour_Point.dart';

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
            child: FloatingActionButton(
              child: const Text("Play"),
              backgroundColor: const Color(0xFFA28AD2),
              foregroundColor: const Color(0xFFFFFFFF),
              onPressed: () => {},
            )),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(widget.tourPoint.name,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: FloatingActionButton(
              child: const Icon(Icons.favorite),
              backgroundColor:
              hearted ? const Color(0xFFA28AD2) : const Color(0xFFFFFFFF),
              onPressed: () {
                setState(() {
                  hearted = !hearted;
                });

              },
            )),
      ],
    );

    return Column(children: [
      row1,
      Expanded(
          child: Container(
              child: SingleChildScrollView(
                  child: Text(widget.tourPoint.description)))),
    ]);
  }
}
