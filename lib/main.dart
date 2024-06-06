import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_app/streaming_functions.dart';
import 'package:sensors_app/widgets/graph_widget.dart';

import 'package:sensors_plus/sensors_plus.dart';

import 'firebase_options.dart';
import 'widgets/stream_transform.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      home: SensorApp(),
    ),
  );
}

class SensorApp extends StatefulWidget {
  SensorApp({super.key});

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
  late StreamSubscription intervalSubscription;
  late StreamSubscription _intervalSubscription;
  late Uri url;
  late FirebaseDatabase database;
  @override
  void initState() {
    super.initState();

    database = FirebaseDatabase.instance;

    Stream<GyroscopeEvent> intervalGyroscopeStream = gyroscopeEventStream()
        .transform(IntervalTransformer<GyroscopeEvent>(Duration(seconds: 2)));
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
        title: const Text("Testing graph widget"),
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
            icon: _showGraph ? Icon(Icons.draw) : Icon(Icons.draw_outlined),
          ),
          _streaming
              ? IconButton(
                  onPressed: () {
                    print("try to stop the stream");
                    stopStream = true;
                    setState(() {
                      _streaming = false;
                      intervalSubscription.cancel();
                    });
                  },
                  icon: Icon(Icons.stop),
                )
              : IconButton(
                  onPressed: () async {
                    final name = await openDialog(context, controller);
                    if (name == null || name.isEmpty) return;
                    DatabaseReference ref = database.ref("users/$name");

                    await ref.set({
                      // "file_name": "$name",
                      "file_name": "$name",
                      "sensor_type": "accelerometer",
                    });
                    setState(() {
                      _streaming = true;
                      newName = name;
                      // _saveItem(name,);
                      intervalSubscription =
                          saveItem(name, stopStream, database);
                    });
                  },
                  icon: Icon(Icons.mic_off_outlined),
                ),
        ],
      ),
      body: _showGraph
          ? Center(
              child: ListView(
                addAutomaticKeepAlives: true,
                children: const [
                  Text("Graph below"),
                  GraphWidget(
                    size: Size(double.infinity, 200),
                    maxPoints: 100,
                    axisName: "x-axis",
                    sensorType: "accelerometer",
                  ),
                  GraphWidget(
                    size: Size(double.infinity, 200),
                    maxPoints: 100,
                    axisName: "y-axis",
                    sensorType: "accelerometer",
                  ),
                  GraphWidget(
                    size: Size(double.infinity, 200),
                    maxPoints: 100,
                    axisName: "z-axis",
                    sensorType: "accelerometer",
                  ),
                  GraphWidget(
                    size: Size(double.infinity, 200),
                    maxPoints: 100,
                    axisName: "x-axis",
                    sensorType: "gyroscope",
                  ),
                  GraphWidget(
                    size: Size(double.infinity, 200),
                    maxPoints: 100,
                    axisName: "y-axis",
                    sensorType: "gyroscope",
                  ),
                  GraphWidget(
                    size: Size(double.infinity, 200),
                    maxPoints: 100,
                    axisName: "z-axis",
                    sensorType: "gyroscope",
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Welcome!"),
                  Text("${this.newName} how are you?"),
                  // Text(this.newName),
                ],
              ),
            ),
    );
  }

  
}
