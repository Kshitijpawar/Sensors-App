import 'dart:math';

import 'package:flutter/material.dart';
import 'package:real_time_chart/real_time_chart.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double accX = 0.0;
  double accY = 0.0;
  double accZ = 0.0;
  double gyroX = 0.0;
  double gyroY = 0.0;
  double gyroZ = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // accelerometer event stream
    userAccelerometerEventStream(samplingPeriod: const Duration(seconds: 1))
        .listen((event) {
      setState(() {
        // print(event.x);
        accX = event.x;

        accY = event.y;
        accZ = event.z;
      });
    });

    // gyroscope event stream
    gyroscopeEventStream(samplingPeriod: const Duration(seconds: 1))
        .listen((event) {
      setState(() {
        gyroX = event.x;
        gyroY = event.y;
        gyroZ = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sensors App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //           "Accelerometer values ${accX.toStringAsFixed(3)} ${accY.toStringAsFixed(3)} ${accZ.toStringAsFixed(3)}"),
      //       const SizedBox(
      //         height: 10,
      //       ),
      //       Text(
      //           "Gyroscope values ${gyroX.toStringAsFixed(3)} ${gyroY.toStringAsFixed(3)} ${gyroZ.toStringAsFixed(3)}"),
      //           RealTimeGraph(stream: positiveDataStream(), graphColor: Colors.red,),

      //     ],
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 125, 10, 125),
        child: RealTimeGraph(
          stream: accelerometerEventStream(),
          graphColor: Colors.red,
        ),
      ),
    );
  }
}

Stream<double> positiveDataStream() {
  return Stream.periodic(const Duration(milliseconds: 500), (_) {
    return Random().nextInt(300).toDouble();
  }).asBroadcastStream();
}
