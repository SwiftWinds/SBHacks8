import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingsPanel extends StatefulWidget {
  const RatingsPanel( {Key? key}) : super (key:key);

  @override
  State<RatingsPanel> createState() => _RatingsPanelState();
}

class _RatingsPanelState extends State<RatingsPanel> {
  var ratingValues = [false, false, false, false, false];

  Widget build(BuildContext context) {
    var ratingStarIcons = <Widget>[];

    // for(int i=0; i<5; i++){
    //   ratingStarIcons[i] = IconButton(
    //       onPressed: () {
    //         for(int j=0; j<=i; j++){
    //           ratingValues[j] = true;
    //         }
    //       },
    //       icon: ratingValues[i]?Icon(Icons.star_rounded):Icon(Icons.star_border_rounded)
    //   );
    // }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Rating?'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('How was the tour?'),
              // Row(
              //     children: ratingStarIcons,
              // ),
              const Image(image: AssetImage('images/Storke.JPG'))
            ],
          ),
        )
    );
  }
}