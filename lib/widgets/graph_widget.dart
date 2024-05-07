// graph_widget.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'random_value_stream.dart';

class GraphWidget extends StatefulWidget {
  const GraphWidget({super.key});

  @override
  _GraphWidgetState createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  final List<int> _data = [];
  final int _maxPoints = 10;
  Stream<int>? _stream;

  @override
  void initState() {
    super.initState();
    _stream = randomValueStream(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (_data.length >= _maxPoints) {
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
        print(_data);
        return CustomPaint(
          size: Size(double.infinity, 100),
          painter: NewGraphPainter(_data, maxPoints: _maxPoints),
        );
      },
    );
  }
}

class NewGraphPainter extends CustomPainter {
  final List<int> data;

  final int maxPoints;

  NewGraphPainter(this.data, {required this.maxPoints});

  @override
  void paint(Canvas canvas, Size size) {
      final int maxYval = data.isNotEmpty?data.reduce(max):0;

    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0;

    final Paint _paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;

    canvas.drawLine(Offset(10, 0), Offset(10, size.height), axisPaint);
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), axisPaint);
    // canvas.drawLine(
    //     Offset(0, size.height), Offset(size.width, size.height), axisPaint);
// Draw the graph line
    final path = Path();
    
    if (data.isNotEmpty) {
      for (int i = 0; i < data.length; i += 1) {

        double x = (size.width / maxPoints) * i + 10;
        // double y = (size.height) - (data[i] * (maxYval / size.height));
        double y = size.height - (data[i] * (maxYval / size.height));
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

class GraphPainter extends CustomPainter {
  final List<int> data;
  final int maxPoints;

  GraphPainter(this.data, {this.maxPoints = 100});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0;
    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;

    // Draw axes
    canvas.drawLine(Offset(0, 0), Offset(0, size.height), axisPaint);
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), axisPaint);

    // // Draw tick marks and labels for the Y axis
    // var yAxisSteps = 5;
    // var maxDataValue = 100.0; // Assuming max Y value is 100 for simplicity
    // var step = maxDataValue / yAxisSteps;
    // for (var i = 0; i <= yAxisSteps; i++) {
    //   double y = size.height - (size.height * i / yAxisSteps);
    //   canvas.drawLine(Offset(-10, y), Offset(0, y), axisPaint);
    //   _drawText(canvas, "${(step * i).toInt()}", -30, y - 6);
    // }

    // Draw tick marks and labels for the X axis
    // var xAxisSteps = maxPoints;
    // var xStep = size.width / xAxisSteps;
    // for (var i = 0; i <= xAxisSteps; i += 10) {
    //   // Adjust step for readability
    //   double x = xStep * i;
    //   canvas.drawLine(
    //       Offset(x, size.height), Offset(x, size.height + 10), axisPaint);
    //   _drawText(canvas, "$i", x - 10, size.height + 20);
    // }

    // Draw the graph line
    final path = Path();
    if (data.isNotEmpty) {
      double xSpacing = size.width / (maxPoints - 1);
      for (int i = 0; i < data.length; i += 2) {
        double x = data[i] * xSpacing;
        double y = size.height - data[i + 1];
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
    }

    canvas.drawPath(path, paint);
  }

  // Helper function to draw text on canvas
  void _drawText(Canvas canvas, String text, double x, double y) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(color: Colors.black, fontSize: 12),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: double.infinity,
    );
    textPainter.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(GraphPainter oldDelegate) => true;
}
