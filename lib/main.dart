import 'package:flutter/material.dart';
import 'package:sensors_app/widgets/graph_widget.dart';
import 'package:sensors_app/widgets/home_screen.dart';

void main() {
  runApp(SensorApp());
}

class SensorApp extends StatelessWidget {
  SensorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensors App',
      // home: HomeScreen(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Testing graph widget"),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Graph below"),
              GraphWidget(
                size: Size(double.infinity, 200),
                maxPoints: 100,
                axisName: "x-axis",
              ),
              GraphWidget(
                size: Size(double.infinity, 200),
                maxPoints: 100,
                axisName: "y-axis",
              ),
              GraphWidget(
                size: Size(double.infinity, 200),
                maxPoints: 100,
                axisName: "z-axis",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
