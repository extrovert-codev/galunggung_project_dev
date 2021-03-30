import 'dart:async';

import 'package:location/location.dart';
import 'package:m_galunggung99/Config/user_location.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Location location = Location();
  StreamController<UserLocation> _locationStreamController =
      StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationStreamController.stream;

  LocationService() {
    Permission.location.request().then((permissionStatus) {
      if (permissionStatus.isGranted) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationStreamController.add(UserLocation(
                latitude: locationData.latitude,
                longitude: locationData.longitude));
          }
        });
      }
    });
  }

  void dispose() => _locationStreamController.close();
}
