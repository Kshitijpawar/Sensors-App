// random_value_stream.dart
import 'dart:async';
import 'dart:math';

Stream<int> randomValueStream(Duration interval) async* {
  final random = Random();
  while (true) {
    await Future.delayed(interval);
    yield random.nextInt(100);
  }
}
