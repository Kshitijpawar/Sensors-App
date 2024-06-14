import 'dart:async';

import 'package:geolocator/geolocator.dart';

// Future<Position> determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // test if location services are enabled
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     return Future.error("Location services are disabled");
//   }
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error("Location permission are denied");
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     return Future.error(
//         "Location permissions are permanently denied, we cannot request permissions");
//   }
//   // return await Geolocator.getCurrentPosition(
//       // desiredAccuracy: LocationAccuracy.high);
// }

Future<String> determinePermissionGranted() async {
  bool serviceEnabled;
  LocationPermission permission;

  // test if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return "Location services are disabled";
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return "Location permission are denied";
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return 
        "Location permissions are permanently denied, we cannot request permissions";
  }
  return "completed permissions";
}


// final LocationSettings locationSettings = LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 50);

// StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
//     (Position? position) {
//         print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
//     });