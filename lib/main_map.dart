import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MainMap extends StatelessWidget {
  const MainMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(center: LatLng(34.413963, -119.848946), zoom: 13),
      layers: [
        TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/jjcooley/ckzaixupv001714pajvojs5i3/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoiampjb29sZXkiLCJhIjoiY2t6YWk0Z2NpMGkydjJvczhjcGN5OXRpYSJ9.buIc71Mdg98-ZHTKDxBoiQ",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1Ijoiampjb29sZXkiLCJhIjoiY2t6YWk0Z2NpMGkydjJvczhjcGN5OXRpYSJ9.buIc71Mdg98-ZHTKDxBoiQ',
              'id': 'mapbox.mapbox-streets-v8'
            }),
        MarkerLayerOptions(markers: [
          Marker(
              width: 80,
              height: 80,
              point: LatLng(34.413963, -119.848946),
              builder: (ctx) => const FlutterLogo())
        ])
      ],
    );
  }
}
