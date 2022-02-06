import 'package:discovar/model/named_point.dart';
import 'package:latlong2/latlong.dart';

class TourPoint extends NamedPoint {
  const TourPoint(String name, LatLng coords, this.description, this.audioPath, this.mlClassID)
      : super(name, coords);

  final String audioPath;
  final String description;
  final String mlClassID;
}
