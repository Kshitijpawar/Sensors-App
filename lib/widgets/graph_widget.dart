// graph_widget.dart
// import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';
import 'random_value_stream.dart';
import 'dart:async';

class GraphWidget extends StatefulWidget {
  final Size size;
  final int maxPoints;
  const GraphWidget({super.key, required this.size, required this.maxPoints});

  @override
  _GraphWidgetState createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  final List<int> _data = [];
  // final List<double> _data = [];
  // final int _maxPoints = 100;
  Stream<int>? _stream;
  // Stream<double>? _stream;
  // Stream<double>? _accStream;
  // final Size size = const Size(double.infinity, 200);

  @override
  void initState() {
    super.initState();
    _stream = randomValueStream(
      interval: const Duration(
        milliseconds: 50,
      ),
      maxVal: 500,
      minVal: -500,
    );

    // _accStream = accelerometerEventStream().map<double>((AccelerometerEvent event) {
      // return event.x;
    // });
  }

  int getMaxVal(currMaxVal, currData) {
    // print("I got till here");
    if (currData >= currMaxVal) return currData;
    return currMaxVal;
  }

  int getMinVal(currMinVal, currData) {
    if (currData < currMinVal) return currData;
    return currMinVal;
  }

  @override
  Widget build(BuildContext context) {
    int maxYvalTest = widget.size.height ~/ 2;
    int minYvalTest = -widget.size.height ~/ 2;
    // return StreamBuilder<double>(
      return StreamBuilder<int>(
      stream: _stream,
      // stream: _accStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (_data.length >= widget.maxPoints) {
            _data.removeAt(0);
          }
          _data.add(snapshot.data!);
        }
        // return CustomPaint(
        //   size: const Size(double.infinity, 200),
        //   // painter: GraphPainter(_data),
        //   painter: GraphPainter(_data, maxPoints: _maxPoints),

        // );
        // return ListView.builder(
        //   itemCount: _data.length,
        //   itemBuilder: (context, index) {
        //     return Text("${_data[index]}");
        //   },
        // );
        // print(_data);

        maxYvalTest =
            _data.isNotEmpty ? getMaxVal(maxYvalTest, snapshot.data!) : 0;
        minYvalTest =
            _data.isNotEmpty ? getMinVal(minYvalTest, snapshot.data!) : 0;

        return CustomPaint(
          size: widget.size,
          painter: NewGraphPainter(
            _data,
            maxPoints: widget.maxPoints,
            currMaxVal: maxYvalTest,
            currMinVal: minYvalTest,
          ),
        );
      },
    );
  }
}

class NewGraphPainter extends CustomPainter {
  final List<int> data;
  // final List<double> data;

  final int maxPoints;
  final int currMaxVal;
  final int currMinVal;

  NewGraphPainter(
    this.data, {
    required this.maxPoints,
    required this.currMaxVal,
    required this.currMinVal,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final Paint _paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;

    // draw y-axis
    canvas.drawLine(Offset(10, 0), Offset(10, size.height), axisPaint);
    // draw x-axis
    // canvas.drawLine(
    // Offset(0, size.height), Offset(size.width, size.height), axisPaint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(size.width, size.height / 2), axisPaint);
    // Draw the graph line
    final path = Path();

    if (data.isNotEmpty) {
      for (int i = 0; i < data.length; i += 1) {
        double x = (size.width / maxPoints) * i + 10;
        // double y = (size.height) - (data[i] * (maxYval / size.height));
        double y = data[i] >= 0
            ? (size.height / 2) - ((data[i] * size.height / 2) / currMaxVal)
            : (size.height / 2) +
                ((data[i] * size.height / 2) / (currMinVal.abs())).abs();
        if (i == 0) {
          path.moveTo(10, y);
        } else {
          path.lineTo(x, y);
        }
        // path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
