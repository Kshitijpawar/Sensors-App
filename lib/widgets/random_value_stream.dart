// random_value_stream.dart
import 'dart:async';
import 'dart:math';

Stream<int> randomValueStream({required Duration interval, required int maxVal, required int minVal}) async* {
  // Stream<double> randomValueStream({required Duration interval, required double maxVal, required double minVal}) async* {
  while (true) {
    await Future.delayed(interval);
   yield minVal + Random().nextInt((maxVal - minVal) as int);
  }
}
