import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

import 'named_point.dart';
import 'tour_point.dart';

class Tour extends NamedPoint
{
  const Tour(String name, this.description, this.rating, LatLng center, this.coverImage, this.points) : super(name, center);

  final List<TourPoint> points;
  final String description;
  final double rating;
  final Image coverImage;
}