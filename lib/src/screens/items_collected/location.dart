import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trashtagApp/src/models/coordinate.dart';

class Location {
  final Geolocator _geolocator = Geolocator();

  static final Location _singleton = Location._internal();

  factory Location() {
    return _singleton;
  }

  Location._internal();

  // TODO Test for iOS
  Future<Coordinate> getCoordinate() async {
    try {
      await requestLocationPermission;

      final position = await _geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      return new Coordinate(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
      );
    } catch (e) {
      return new Coordinate();
    }
  }

  // TODO Test for iOS
  Future<void> get requestLocationPermission async {
    try {
      final bool isGranted = await Permission.location.isGranted;
      if (!isGranted) {
        await Permission.location.request();
      }
    } catch (e) {}
  }
}
