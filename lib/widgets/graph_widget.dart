import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

class GraphWidget extends StatefulWidget {
  final Size size;
  final int maxPoints;
  final String axisName;
  final String sensorType;
  const GraphWidget({
    super.key,
    required this.size,
    required this.maxPoints,
    required this.axisName,
    required this.sensorType,
  });

  @override
  _GraphWidgetState createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> with AutomaticKeepAliveClientMixin{
  final List<double> _data = [];
  // Stream<double>? _accStream;
  Stream<double>? _sensorStream;

  @override
  void initState() {
    super.initState();

    if (widget.sensorType == "accelerometer") {
      _sensorStream =
          accelerometerEventStream().map<double>((AccelerometerEvent event) {
        switch (widget.axisName) {
          case "x-axis":
            return event.x;
          case "y-axis":
            return event.y;
          case "z-axis":
            return event.z;
          default:
            return event.x;
        }
      });
    } else if (widget.sensorType == "gyroscope") {
      _sensorStream =
          gyroscopeEventStream().map<double>((GyroscopeEvent event) {
        switch (widget.axisName) {
          case "x-axis":
            return event.x;
          case "y-axis":
            return event.y;
          case "z-axis":
            return event.z;
          default:
            return event.x;
        }
      });
    }
  }

  double getMaxVal(currMaxVal, currData) {
    if (currData >= currMaxVal) return currData;
    return currMaxVal;
  }

  double getMinVal(currMinVal, currData) {
    if (currData < currMinVal) return currData;
    return currMinVal;
  }

  @override
  Widget build(BuildContext context) {
    late double maxYvalTest = -double.infinity;
    late double minYvalTest = double.infinity;
    return StreamBuilder<double>(
      // stream: _accStream,
      stream: _sensorStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (_data.length >= widget.maxPoints) {
            _data.removeAt(0);
          }
          _data.add(snapshot.data!);
        }
        maxYvalTest = snapshot.data != null
            ? getMaxVal(maxYvalTest, snapshot.data!)
            : maxYvalTest;
        minYvalTest = snapshot.data != null
            ? getMinVal(minYvalTest, snapshot.data!)
            : minYvalTest;
        return Container(
          margin: const EdgeInsets.fromLTRB(0, 3.0, 0, 3.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: CustomPaint(
            size: widget.size,
            painter: NewGraphPainter(
              _data,
              maxPoints: widget.maxPoints,
              currMaxVal: maxYvalTest,
              currMinVal: minYvalTest,
            ),
          ),
        );
      },
    );
  }
  
  @override
  bool get wantKeepAlive =>true;
}

class NewGraphPainter extends CustomPainter {
  final List<double> data;
  final int maxPoints;
  final double currMaxVal;
  final double currMinVal;

  NewGraphPainter(
    this.data, {
    required this.maxPoints,
    required this.currMaxVal,
    required this.currMinVal,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;

    canvas.drawLine(const Offset(10, 0), Offset(10, size.height), axisPaint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(size.width, size.height / 2), axisPaint);
    final path = Path();

    if (data.isNotEmpty) {
      for (int i = 0; i < data.length; i += 1) {
        double x = (size.width / maxPoints) * i + 10;
        double y = data[i] >= 0
            ? (size.height / 2) - ((data[i] * size.height / 2) / currMaxVal)
            : (size.height / 2) +
                ((data[i] * size.height / 2) / (currMinVal.abs())).abs();
        if (i == 0) {
          path.moveTo(10, y);
        } else {
          path.lineTo(x, y);
        }
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
