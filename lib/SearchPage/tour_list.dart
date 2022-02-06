import 'package:flutter/material.dart';

class TourList extends StatefulWidget {
  const TourList({Key? key}) : super(key: key);

  ListTile _tile(String title, String subtitle, IconData icon) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(subtitle),
      leading: Icon(
        icon,
        color: Colors.blue[500],
      ),
    );
  }

  @override
  State<TourList> createState() => _TourListState();
}

class _TourListState extends State<TourList>{

  static ListTile _tile(String title, String subtitle, IconData icon) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(subtitle),
      leading: Icon(
        icon,
        color: Colors.blue[500],
      ),
    );
  }

  var tourList = [
    _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
    _tile('The Castro Theater', '429 Castro St', Icons.theaters),
    _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
    _tile('Roxie Theater', '3117 16th St', Icons.theaters)
  ];
  // void _makeList(){
  //   setState(() {
  //
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: tourList
    );
  }
}

