import 'package:flutter/material.dart';
import 'package:sensors_app/widgets/home_screen.dart';

void main() {
  runApp(const SensorApp());
}

class SensorApp extends StatelessWidget {
  const SensorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sensors App',
      home: HomeScreen(),
    );
  }
}

