import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_app/streaming_functions.dart';
import 'package:sensors_app/widgets/graph_widget.dart';

import 'package:sensors_plus/sensors_plus.dart';

import 'firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

ValueNotifier<bool> isSwitchedGyroscope = ValueNotifier<bool>(false);
ValueNotifier<bool> isSwitchedAccelerometer = ValueNotifier<bool>(false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MaterialApp(
      home: SensorApp(),
    ),
  );
}

class SensorApp extends StatefulWidget {
  const SensorApp({super.key});

  @override
  State<SensorApp> createState() => _SensorAppState();
}

class _SensorAppState extends State<SensorApp> {
  bool _showGraph = false;
  bool _streaming = false;
  bool stopStream = false;
  late TextEditingController controller;
  String newName = '';
  late Stream<AccelerometerEvent> intervalAccelerometerStream;
  late Stream<GyroscopeEvent> intervalGyroscopeStream;
  late StreamSubscription intervalAccSubscription;
  late StreamSubscription intervalGyroSubscription;
  late FirebaseDatabase database;

  @override
  void initState() {
    super.initState();
    database = FirebaseDatabase.instance;
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sensors viz and recording"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (_showGraph) {
                  _showGraph = false;
                } else {
                  _showGraph = true;
                }
              });
            },
            icon: _showGraph
                ? const Icon(Icons.draw)
                : const Icon(Icons.draw_outlined),
          ),
          _streaming
              ? IconButton(
                  onPressed: () {
                    stopStream = true;
                    setState(() {
                      _streaming = false;
                      isSwitchedAccelerometer.value =
                          !isSwitchedAccelerometer.value;
                      isSwitchedGyroscope.value = !isSwitchedGyroscope.value;
                      intervalAccSubscription.cancel();
                      intervalGyroSubscription.cancel();
                    });
                  },
                  icon: const Icon(Icons.stop),
                )
              : IconButton(
                  onPressed: () async {
                    final name = await openDialog(context, controller,
                        isSwitchedAccelerometer, isSwitchedGyroscope);
                    if (name == null || name.isEmpty) return;

                    DatabaseReference ref = database.ref("users/$name");

                    await ref.set({
                      "file_name": name,
                    });
                    setState(() {
                      _streaming = true;
                      newName = name;

                      if (isSwitchedGyroscope.value) {
                        intervalAccSubscription = saveSensorItem(
                            name, stopStream, database, "gyroscope");
                      }
                      if (isSwitchedAccelerometer.value) {
                        intervalGyroSubscription = saveSensorItem(
                            name, stopStream, database, "accelerometer");
                      }

                      if (isSwitchedAccelerometer.value == false &&
                          isSwitchedGyroscope.value == false) {
                        return;
                      }
                    });
                  },
                  icon: const Icon(Icons.mic),
                ),
        ],
      ),
      body: _showGraph
          ? Center(
              child: ListView(
                addAutomaticKeepAlives: true,
                children: const [
                  GraphWidget(
                    size: Size(double.infinity, 200),
                    maxPoints: 100,
                    axisName: "x-axis",
                    sensorType: "accelerometer",
                  ),
                  // GraphWidget(
                  //   size: Size(double.infinity, 200),
                  //   maxPoints: 100,
                  //   axisName: "y-axis",
                  //   sensorType: "accelerometer",
                  // ),
                  // GraphWidget(
                  //   size: Size(double.infinity, 200),
                  //   maxPoints: 100,
                  //   axisName: "z-axis",
                  //   sensorType: "accelerometer",
                  // ),
                  // GraphWidget(
                  //   size: Size(double.infinity, 200),
                  //   maxPoints: 100,
                  //   axisName: "x-axis",
                  //   sensorType: "gyroscope",
                  // ),
                  // GraphWidget(
                  //   size: Size(double.infinity, 200),
                  //   maxPoints: 100,
                  //   axisName: "y-axis",
                  //   sensorType: "gyroscope",
                  // ),
                  // GraphWidget(
                  //   size: Size(double.infinity, 200),
                  //   maxPoints: 100,
                  //   axisName: "z-axis",
                  //   sensorType: "gyroscope",
                  // ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Welcome!"),
                  Text("$newName how are you?"),
                  ValueListenableBuilder(
                      valueListenable: isSwitchedAccelerometer,
                      builder: (context, value, _) =>
                          Text("recording $value accelerometer data")),
                  ValueListenableBuilder(
                      valueListenable: isSwitchedGyroscope,
                      builder: (context, value, _) =>
                          Text("recording $value gyroscope data")),
                ],
              ),
            ),
    );
  }
}