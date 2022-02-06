import 'package:flutter/material.dart';

import '../model/tour.dart';

class InformationBox extends StatelessWidget {
  const InformationBox({Key? key, required this.selectedTour})
      : super(key: key);
  final Tour selectedTour;

  @override
  Widget build(BuildContext context) {
    var ratingValues = [0, 0, 0, 0, 0];
    for (int i = 0; i < selectedTour.rating; i++) {
      ratingValues[i] = 2;
    }
    var decimalStarRating = selectedTour.rating - selectedTour.rating.floor();
    if (decimalStarRating >= 0.5) {
      ratingValues[selectedTour.rating.floor()] = 1;
    }

    var row1 = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(width: 100, height: 100, child: selectedTour.coverImage)
            )
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(selectedTour.name,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: FloatingActionButton(
              child: const Text("Go"),
              backgroundColor: const Color(0xFFA28AD2),
              foregroundColor: const Color(0xFFFFFFFF),
              onPressed: () => {},
            ))
      ],
    );
    final ratings = Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...ratingValues.map((rating) {
              if (rating == 0) {
                return const Icon(Icons.star_border_rounded, size: 40);
              } else if (rating == 1) {
                return const Icon(Icons.star_half_rounded,
                    color: Colors.yellow, size: 40);
              } else {
                return const Icon(Icons.star_rounded,
                    color: Colors.yellow, size: 40);
              }
            }),
          ],
        ));
    return Column(children: [row1, ratings]);
  }
}
