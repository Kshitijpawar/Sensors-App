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
    return const MaterialApp(
      title: 'Sensors App',
      home: HomeScreen(),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text("Testing graph widget"),
      //   ),
      //   body: Center(child: GraphWidget()),
      // ),
    );
  }
}
