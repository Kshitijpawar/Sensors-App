import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // double accX = 0.0;
  // double accY = 0.0;
  // double accZ = 0.0;
  late String accX;
  late String accY;
  late String accZ;

  late String gyroX;
  late String gyroY;
  late String gyroZ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // accelerometer event stream
    accelerometerEventStream(samplingPeriod: const Duration(seconds: 1))
        .listen((event) {
      setState(() {
        // print(event.x);
        accX = event.x.toStringAsFixed(3);
        accY = event.y.toStringAsFixed(3);
        accZ = event.z.toStringAsFixed(3);
      });
    });

    // gyroscope event stream
    gyroscopeEventStream(samplingPeriod: const Duration(seconds: 1))
        .listen((event) {
      setState(() {
        gyroX = event.x.toStringAsFixed(3);
        gyroY = event.y.toStringAsFixed(3);
        gyroZ = event.z.toStringAsFixed(3);
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
      body: Center(
        child: Column(
          children: [
            Text("Accelerometer values $accX $accY $accZ"),
            const SizedBox(height: 10,),
            Text("Gyroscope values $gyroX $gyroY $gyroZ")
          ],
        ),
      ),
    );
  }
}
