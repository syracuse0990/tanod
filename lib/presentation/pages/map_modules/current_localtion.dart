import 'package:geolocator/geolocator.dart';

import '../../../app/util/util.dart';

class UserCurrentLocation {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled


    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled
      showToast(message: "Location services are disabled.");
      return Future.error('Location services are disabled.');
    }

    // Check if the app has permission to access the user's location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Permission is denied forever, handle accordingly.
      showToast(
          message:
              "Location permissions are permanently denied, we cannot request permissions.");
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      // Permission is denied, request permissions
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Permission is denied, handle accordingly
        showToast(
            message:
                "Location permissions are denied (actual value: $permission).");

        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    // Get the current location
    return await Geolocator.getCurrentPosition();
  }
}
