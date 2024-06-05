import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:sensors_app/widgets/alert_dialog.dart';
import 'package:sensors_app/widgets/graph_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sensors_plus/sensors_plus.dart';

import 'widgets/stream_transform.dart';

void main() {
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
  late TextEditingController controller;
  String newName = '';
  late Stream<AccelerometerEvent> intervalAccelerometerStream;
  late Stream<GyroscopeEvent> intervalGyroscopeStream;
  late Uri url;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    url = Uri.https(
        'flutter-prep-bda5b-default-rtdb.firebaseio.com', 'new-list.json');

    // Stream<AccelerometerEvent> intervalAccelerometerStream =
    //     accelerometerEventStream().transform(
    //         IntervalTransformer<AccelerometerEvent>(Duration(seconds: 2)));

    Stream<GyroscopeEvent> intervalGyroscopeStream = gyroscopeEventStream()
        .transform(IntervalTransformer<GyroscopeEvent>(Duration(seconds: 2)));
    // print("Sensors initialized");
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
          IconButton(
            onPressed: () async {
              final name = await openDialog();
              if (name == null || name.isEmpty) return;

              setState(() {
                newName = name;
                _saveItem();
              });
            },
            icon: Icon(
              Icons.mic_off_outlined,
            ),
          ),
        ],
      ),
      body: _showGraph
          ? Center(
              child: ListView(
                addAutomaticKeepAlives: true,
                // mainAxisAlignment: MainAxisAlignment.start,
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

  Future<String?> openDialog() => showDialog<String>(
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
              onPressed: submit,
              child: Text("Submit"),
            ),
          ],
        ),
      );
  void submit() {
    Navigator.of(context).pop(controller.text);
  }

  void _saveItem() async {
    Stream<AccelerometerEvent> intervalAccelerometerStream =
        accelerometerEventStream().transform(
            IntervalTransformer<AccelerometerEvent>(Duration(milliseconds: 500  )));
    print("sensors initialized");
    intervalAccelerometerStream.listen((event) async {
      print(event);

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "sensor_type": "accelerometer",
            "file_name": this.newName,
            "data" : {
              "x" : event.x,
              "y" : event.y,
              "z" : event.z,
            }
          },
        ),
      );

      print(response.body);
      print(response.statusCode);
    });
    // final url = Uri.https(
    // 'flutter-prep-bda5b-default-rtdb.firebaseio.com', 'new-list.json');

    // final response = await http.post(
    //   url,
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    //   body: json.encode(
    //     {
    //       "name": this.newName,
    //       "timestamp": DateTime.now().toString(),
    //       // "quantity": _enteredQuantity,
    //       // "category": _selectedCategory.title,
    //     },
    //   ),
    // );
    // print(response.body);
    // print(response.statusCode);
  }

  Future<int> myFuture(int n) async {
    var seconds = Random().nextInt(25);
    Future.delayed(Duration(seconds: seconds)); // Mock future
    print("Future finished for: $n, completion time: $seconds");
    return n;
  }
}
