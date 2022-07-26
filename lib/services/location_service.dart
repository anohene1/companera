
import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<void> requestPermission() async {
    late bool _serviceEnabled;
    late PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<void> enableBackgroundMode() async {
    await location.enableBackgroundMode(enable: true);

  }

  Future<LocationData> getLocation() async {

    return await location.getLocation();

  }
}