import 'package:discovar/model/named_point.dart';
import 'package:latlong2/latlong.dart';

class TourPoint extends NamedPoint {
  const TourPoint(String name, LatLng coords, this.audioPath)
      : super(name, coords);

  final String audioPath;
}
