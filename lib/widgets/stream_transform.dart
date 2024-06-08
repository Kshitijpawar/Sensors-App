import 'dart:async';

class IntervalTransformer<T> extends StreamTransformerBase<T, T> {
  final Duration interval;
  final StreamTransformer<T, T> _transformer;

  IntervalTransformer(this.interval) : _transformer = _createTransformer(interval);

  static StreamTransformer<T, T> _createTransformer<T>(Duration interval) {
    return StreamTransformer<T, T>((Stream<T> input, bool cancelOnError) {
      late StreamController<T> controller;
      late StreamSubscription<T> subscription;
      Timer? timer;
      late T? latestEvent;

      void onTimer() {
        if (latestEvent != null) {
          controller.add(latestEvent!);
          latestEvent = null;
        }
      }

      controller = StreamController<T>(
        onListen: () {
          subscription = input.listen(
            (data) {
              latestEvent = data;
            },
            onError: controller.addError,
            onDone: () {
              timer?.cancel();
              controller.close();
            },
            cancelOnError: cancelOnError,
          );

          timer = Timer.periodic(interval, (timer) => onTimer());
        },
        onPause: () {
          subscription.pause();
          timer?.cancel();
        },
        onResume: () {
          subscription.resume();
          timer = Timer.periodic(interval, (timer) => onTimer());
        },
        onCancel: () {
          subscription.cancel();
          timer?.cancel();
        },
      );

      return controller.stream.listen(null);
    });
  }

  @override
  Stream<T> bind(Stream<T> stream) => _transformer.bind(stream);
}