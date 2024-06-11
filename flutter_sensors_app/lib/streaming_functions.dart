import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'widgets/stream_transform.dart';

Future<String?> openDialog(
  BuildContext context,
  TextEditingController controller,
  ValueNotifier<bool> isSwitchedAccelerometer,
  ValueNotifier<bool> isSwitchedGyroscope,
) {
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Enter recording file name"),
      content: StatefulBuilder(builder: (context, setState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(hintText: "enter file name"),
            ),
            const SizedBox(height: 20),
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
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text("Gyroscope Recording"),
                Switch(
                    value: isSwitchedGyroscope.value,
                    onChanged: (value) {
                      setState(() {
                        isSwitchedGyroscope.value = !isSwitchedGyroscope.value;
                      });
                    }),
              ],
            ),
          ],
        );
      }),
      actions: <Widget>[
        TextButton(
          onPressed: () => submit(context, controller),
          child: const Text("Start Recording"),
        ),
      ],
    ),
  );
}

void submit(BuildContext context, TextEditingController controller) {
  Navigator.of(context).pop(controller.text);
}

void stopAccStream(StreamSubscription intervalSubscription) {
  intervalSubscription.cancel();
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
      if (stopStream) {
        intervalSubscription.cancel();
      }
      print(event);
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
      if (stopStream) {
        intervalSubscription.cancel();
      }
      print(event);
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
  }
  throw StreamSubscriptionException();
}

class StreamSubscriptionException implements Exception {
  String errMsg() => "No StreamSubscription Returned";
}
