import 'package:flutter/material.dart';
import 'package:sensors_app/widgets/graph_widget.dart';

void main() {
  runApp(SensorApp());
}

class SensorApp extends StatefulWidget {
  SensorApp({super.key});

  @override
  State<SensorApp> createState() => _SensorAppState();
}

class _SensorAppState extends State<SensorApp> {
  bool _showGraph = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensors App',
      // home: HomeScreen(),
      home: Scaffold(
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
            : const Center(
                child: Text("Welcome!"),
              ),
      ),
    );
  }
}
