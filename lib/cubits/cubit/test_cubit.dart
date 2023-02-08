import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

enum StopwatchEvent { start, stop, reset, lap }

class StopTestCubit extends Cubit<Duration> {
  late Timer _timer;
  Stopwatch stopwatch = Stopwatch();
  StopTestCubit() : super(Duration.zero);

  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      emit(stopwatch.elapsed);
    });
  }

  void onStopwatchEvent(StopwatchEvent event) {
    switch (event) {
      case StopwatchEvent.start:
        stopwatch.start();
        startTimer();
        break;
      case StopwatchEvent.stop:
        stopwatch.stop();
        _timer.cancel();
        break;
      case StopwatchEvent.reset:
        stopwatch.reset();
        _timer.cancel();
        emit(Duration.zero);
        break;
      case StopwatchEvent.lap:
        break;
    }
  }
}
