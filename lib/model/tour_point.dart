import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

class TourPoint
{
  const TourPoint(this.name, this.coords, this.image);

  final String name;
  final LatLng coords;
  final Image image;
}