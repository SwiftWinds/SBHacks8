import 'package:latlong2/latlong.dart';

class NamedPoint {
  const NamedPoint(this.name, this.coords);

  final String name;
  final LatLng coords;
}
