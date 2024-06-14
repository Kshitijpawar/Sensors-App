import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensors_app/gps_functions.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'widgets/stream_transform.dart';

Future<String?> openDialog(
  BuildContext context,
  TextEditingController controller,
  // TextEditingController freqAccController,
  ValueNotifier<bool> isSwitchedAccelerometer,
  ValueNotifier<bool> isSwitchedGyroscope,
  ValueNotifier<bool> isSwitchedLocation,
) {
  // String checkPermissionGranted = await determinePermissionGranted();
  // print(checkPermissionGranted);
  return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Stream Sensor Values to Firebase RTDB"),
          content: StatefulBuilder(builder: (context, setState) {
            // String hasLocationPermission = "no location permission granted";
            Future<String> determinePosition() async {
              bool serviceEnabled;
              LocationPermission permission;

              // test if location services are enabled
              serviceEnabled = await Geolocator.isLocationServiceEnabled();
              if (!serviceEnabled) {
                return Future.error("Location services are disabled");
              }
              permission = await Geolocator.checkPermission();
              if (permission == LocationPermission.denied) {
                permission = await Geolocator.requestPermission();
                if (permission == LocationPermission.denied) {
                  return Future.error("Location permission are denied");
                }
              }

              if (permission == LocationPermission.deniedForever) {
                return Future.error(
                    "Location permissions are permanently denied, we cannot request permissions");
              }
              return Future.value("location permission granted");
              // return await Geolocator.getCurrentPosition(
              // desiredAccuracy: LocationAccuracy.high);
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller,
                    autofocus: true,
                    decoration: const InputDecoration(
                        hintText: "enter recording file name"),
                  ),
                  // const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Accelerometer Recording"),
                      Switch(
                          value: isSwitchedAccelerometer.value,
                          onChanged: (value) {
                            setState(() {
                              isSwitchedAccelerometer.value =
                                  !isSwitchedAccelerometer.value;
                            });
                          }),
                      //         TextField(
                      //   controller: freqAccController,
                      //   // autofocus: true,
                      //   decoration: const InputDecoration(hintText: "Enter sensor recording frequency (in ms)"),
                      // ),
                    ],
                  ),
                  // const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text("Gyroscope Recording"),
                      Switch(
                          value: isSwitchedGyroscope.value,
                          onChanged: (value) {
                            setState(() {
                              isSwitchedGyroscope.value =
                                  !isSwitchedGyroscope.value;
                            });
                          }),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Location Recording"),
                      Switch(
                          value: isSwitchedLocation.value,
                          onChanged: (value) {
                            setState(() {
                              isSwitchedLocation.value =
                                  !isSwitchedLocation.value;
                            });
                          }),
                    ],
                  ),
                  // FutureBuilder(
                  //   future: determinePosition(),
                  //   builder:
                  //       (BuildContext context, AsyncSnapshot<String> snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return Text("loading");
                  //     } else if (snapshot.hasError) {
                  //       return Text('Error: ${snapshot.error}');
                  //     } else {
                  //       // return Text('Result: ${snapshot.data}');
                  //       return Row(
                  //         children: [
                  //           const Text("Location Recording"),
                  //           Switch(
                  //               value: isSwitchedLocation.value,
                  //               onChanged: (value) {
                  //                 setState(() {
                  //                   isSwitchedLocation.value =
                  //                       !isSwitchedLocation.value;
                  //                 });
                  //               }),
                  //         ],
                  //       );
                  //     }
                  //   },
                  // ),
                ],
              ),
            );
          }),
          actions: <Widget>[
            TextButton(
              onPressed: () => submit(context, controller),
              child: const Text("Start Recording"),
            ),
          ],
        );
      });
}

void submit(BuildContext context, TextEditingController controller) {
  Navigator.of(context).pop(controller.text);
}

StreamSubscription saveSensorItem(
  String fileName,
  bool stopStream,
  FirebaseDatabase database,
  sensorType,
) {
  late StreamSubscription intervalSubscription;

  if (sensorType == "accelerometer") {
    Stream<UserAccelerometerEvent> intervalAccelerometerStream =
        userAccelerometerEventStream().transform(
      IntervalTransformer<UserAccelerometerEvent>(
        // const Duration(milliseconds: 1000),
        const Duration(milliseconds: 100),
      ),
    );

    intervalSubscription = intervalAccelerometerStream.listen((event) async {
      DatabaseReference ref = database.ref("users/$fileName/$sensorType");
      DatabaseReference newRef = ref.push();
      newRef.set({
        "data": {
          "x": event.x,
          "y": event.y,
          "z": event.z,
          "timestamp": DateTime.now().toString(),
        },
      });
    });
    return intervalSubscription;
  } else if (sensorType == "gyroscope") {
    Stream<GyroscopeEvent> intervalGyroscopeStream =
        gyroscopeEventStream().transform(
      IntervalTransformer<GyroscopeEvent>(
        // const Duration(milliseconds: 1000),
        const Duration(milliseconds: 100),
      ),
    );

    intervalSubscription = intervalGyroscopeStream.listen((event) async {
      DatabaseReference ref = database.ref("users/$fileName/$sensorType");
      DatabaseReference newRef = ref.push();
      newRef.set({
        "data": {
          "x": event.x,
          "y": event.y,
          "z": event.z,
          "timestamp": DateTime.now().toString(),
        },
      });
    });
    return intervalSubscription;
  } else if (sensorType == "location") {
    const LocationSettings locationSettings =
        LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 50);
    intervalSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((event) {
      DatabaseReference ref = database.ref("users/$fileName/$sensorType");
      DatabaseReference newRef = ref.push();
      newRef.set({
        "data": {
          "latitude": event.latitude,
          "longitude": event.longitude,
          "speed": event.speed,
          "timestamp": event.timestamp.toString(),
        },
      });
    });
    return intervalSubscription;
  }
  throw StreamSubscriptionException();
}

class StreamSubscriptionException implements Exception {
  String errMsg() => "No StreamSubscription Returned";
}
