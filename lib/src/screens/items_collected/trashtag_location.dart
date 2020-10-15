import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trashtagApp/src/models/coordinate.dart';
import 'package:location/location.dart' as l;

class TrashTagLocation {

  static final TrashTagLocation _singleton = TrashTagLocation._internal();

  factory TrashTagLocation() {
    return _singleton;
  }

  TrashTagLocation._internal();

  Future<Coordinate> getCoordinate() async {
    try {
      await requestLocationPermission;

      if (Platform.isAndroid) {
        Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);    

        return new Coordinate(
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString(),
        );
      } 

      if (Platform.isIOS) {
        l.Location location = new l.Location();
        l.LocationData position = await location.getLocation();
        return new Coordinate(
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString(),
        );
      }

      return new Coordinate();
    } catch (e) {
      return new Coordinate();
    }
  }

  Future<void> get requestLocationPermission async {
    try {
      if (Platform.isAndroid) {
        final bool isGranted = await Permission.location.isGranted;
        if (!isGranted) {
          await Permission.location.request();
        }
      }  
 
      if (Platform.isIOS) {
        l.Location location = new l.Location();
        bool serviceEnabled = await location.serviceEnabled();
        if (!serviceEnabled) {
          serviceEnabled = await location.requestService();
        }

        l.PermissionStatus permissionGranted = await location.hasPermission();
        if (permissionGranted == l.PermissionStatus.denied) {
          permissionGranted = await location.requestPermission();
        }
      }
    } catch (e) {}
  }
}
