import 'package:flutter/material.dart';

import 'model/tour.dart';

class RatingsPanel extends StatefulWidget {
  const RatingsPanel(this.currentTour, this.setCurrentTour, {Key? key}) : super (key:key);

  final Tour? currentTour;
  final dynamic setCurrentTour;

  @override
  State<RatingsPanel> createState() => _RatingsPanelState();
}

class _RatingsPanelState extends State<RatingsPanel> {
  var ratingValues = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    var ratingStarIcons = <Widget>[];

    for(int i=0; i<5; i++){
      ratingStarIcons.add(
          IconButton(
            onPressed: (){
              setState(() {
                for(int j=0; j<=i; j++){
                  ratingValues[j] = true;
                }
                for(int j=4; j>i; j--){
                  ratingValues[j] = false;
                }
              });
            },
            icon: ratingValues[i] ?
            const Icon(Icons.star_rounded, size: 45, color: Color(0xFFF0F020)) :
            const Icon(Icons.star_border_rounded, size: 45, color: Color(0xFFF0F020))
        )
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Rating?'),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white
            ),
            onPressed: () {
              setState(() {
                widget.setCurrentTour(null, boundsMargin: 2.0);
              });
              Navigator.pop(context);
            }
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: const Text('How was the tour?',
                  style: TextStyle(
                      fontSize: 40
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ratingStarIcons,
              ),
              Container(
                child: widget.currentTour!.coverImage,
                height: MediaQuery.of(context).size.height/3*2,
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 50)
              )
            ],
          ),
        )
    );
  }
}