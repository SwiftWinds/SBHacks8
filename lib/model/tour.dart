import 'package:flutter/material.dart';
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

  ListTile toTile(Function(Tour) onTourSelect) {
    return ListTile(
      title: Text(name,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(description),
      leading: coverImage,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(rating.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              )
          ),
          const Icon(Icons.star)
        ],
      ),
      onTap: () {
        onTourSelect(this);
      }
    );
  }
}