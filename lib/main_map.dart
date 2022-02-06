import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'model/tour.dart';

class MainMap extends StatelessWidget
{
  const MainMap(this.tours, this.selectedTour, this.setSelectedTour, this.setSelectedTourPoint, this.controller, this.defaultBounds, {Key? key}) : super(key: key);

  final List<Tour> tours;
  final Tour? selectedTour;
  final dynamic setSelectedTour;
  final dynamic setSelectedTourPoint;
  final MapController controller;
  final LatLngBounds defaultBounds;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: controller,
      options: MapOptions(center: LatLng(34.413963, -119.848946), zoom: 13, bounds: defaultBounds),
      layers: [
        TileLayerOptions(
            urlTemplate:
            "https://api.mapbox.com/styles/v1/jjcooley/ckzaixupv001714pajvojs5i3/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoiampjb29sZXkiLCJhIjoiY2t6YWk0Z2NpMGkydjJvczhjcGN5OXRpYSJ9.buIc71Mdg98-ZHTKDxBoiQ",
            additionalOptions: {
              'accessToken':
              'pk.eyJ1Ijoiampjb29sZXkiLCJhIjoiY2t6YWk0Z2NpMGkydjJvczhjcGN5OXRpYSJ9.buIc71Mdg98-ZHTKDxBoiQ',
              'id': 'mapbox.mapbox-streets-v8'
            }),
        MarkerLayerOptions(markers:
          selectedTour == null
            ? tours.map((tour) => tour.toMarker(() {
              setSelectedTour(tour);
            })).toList()
            : selectedTour!.points.map((tourPoint) => tourPoint.toMarker(() {
              setSelectedTourPoint(tourPoint);
            })).toList()
        )
      ],
    );
  }
}
