import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

import 'tour_point.dart';

class Tour extends TourPoint
{
  const Tour(String name, LatLng center, Image coverImage, this.points) : super(name, center, coverImage);

  final List<TourPoint> points;
}