import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'widgets/stream_transform.dart';

Future<String?> openDialog(
        BuildContext context, TextEditingController controller) =>
    showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Your Name"),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(hintText: "enter your name"),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => submit(context, controller),
            child: Text("Submit"),
          ),
        ],
      ),
    );
void submit(BuildContext context, TextEditingController controller) {
  Navigator.of(context).pop(controller.text);
}

void stopAccStream(StreamSubscription intervalSubscription) {
  intervalSubscription.cancel();
}

StreamSubscription saveItem(
  String fileName,
  bool stopStream,
  FirebaseDatabase database,
)  {
  late StreamSubscription intervalSubscription;

  Stream<AccelerometerEvent> intervalAccelerometerStream =
      accelerometerEventStream().transform(
    IntervalTransformer<AccelerometerEvent>(
      Duration(seconds: 2),
    ),
  );

  intervalSubscription = intervalAccelerometerStream.listen((event) async {
    if (stopStream) {
      intervalSubscription.cancel();
    }
    print(event);
    // print(file_name);
    DatabaseReference ref = database.ref("users/$fileName");
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
