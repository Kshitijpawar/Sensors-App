// graph_widget.dart
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'random_value_stream.dart';
import 'dart:async';

class GraphWidget extends StatefulWidget {
  final Size size;
  final int maxPoints;
  final String axisName;
  const GraphWidget(
      {super.key,
      required this.size,
      required this.maxPoints,
      required this.axisName});

  @override
  _GraphWidgetState createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  // final List<int> _data = [];
  final List<double> _data = [];
  // final int _maxPoints = 100;
  // Stream<int>? _stream;
  // Stream<double>? _stream;
  Stream<double>? _accStream;
  // final Size size = const Size(double.infinity, 200);

  @override
  void initState() {
    super.initState();
    // _stream = randomValueStream(
    //   interval: const Duration(
    //     milliseconds: 100,
    //   ),
    //   maxVal: 500.0,
    //   minVal: -500.0,
    // );

    _accStream =
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
  }

  double getMaxVal(currMaxVal, currData) {
    // something in the way hmmmmmmmmmm.. ok so i dont why i was abs currData

    if (currData >= currMaxVal) return currData;
    return currMaxVal;
  }

  double getMinVal(currMinVal, currData) {
    if (currData < currMinVal) return currData;
    return currMinVal;
  }

  @override
  Widget build(BuildContext context) {
    // double maxYvalTest = widget.size.height / 2;
    // double minYvalTest = -widget.size.height / 2;
    late double maxYvalTest = -double.infinity;
    late double minYvalTest = double.infinity;
    return StreamBuilder<double>(
      // return StreamBuilder<int>(
      // stream: _stream,
      stream: _accStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // print(snapshot.data);
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

        maxYvalTest = snapshot.data != null
            ? getMaxVal(maxYvalTest, snapshot.data!)
            : maxYvalTest;
        minYvalTest = snapshot.data != null
            ? getMinVal(minYvalTest, snapshot.data!)
            : minYvalTest;
        // print("the max values is $maxYvalTest and the min val is $minYvalTest");
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
}

class NewGraphPainter extends CustomPainter {
  // final List<int> data;
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
          // if (y > size.height) {
          //   print(
          //       "calculating $x and y : $y (data was : ${data[i]}) with $currMaxVal as max and $currMinVal as min val");
          // }
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
