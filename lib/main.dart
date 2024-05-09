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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Graph below"),
              GraphWidget(
                size: Size(double.infinity, 600),
                maxPoints: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
