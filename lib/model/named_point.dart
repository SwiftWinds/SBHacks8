import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class NamedPoint {
  const NamedPoint(this.name, this.coords);

  final String name;
  final LatLng coords;

  Marker toMarker(onPressed)
  {
    return Marker(
      width: 120,
      height: 120,
      point: coords,
      builder: (ctx) => IconButton(
        icon: Image.asset('images/redpin.png'),
        iconSize: 50,
        onPressed: () { onPressed(); },
      )
    );
  }
}
