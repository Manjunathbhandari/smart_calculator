import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcalculator/cubits/states/stopwatch_state.dart';

class StopWatchCubit extends Cubit<StopWatchState> {
  Stopwatch stopwatch = Stopwatch();
  late Timer _timer;
  List<String> lapTime = [];

  StopWatchCubit()
      : super(
            StopWatchState(elapsed: Duration.zero, isRunning: false, laps: []));

  void startStopWatch() {
    stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 100), updateTime);
    emit(StopWatchState(
      elapsed: stopwatch.elapsed,
      isRunning: true,
      laps: state.laps,
    ));
  }

  void stopStopWatch() {
    stopwatch.stop();
    _timer.cancel();
    emit(StopWatchState(
      elapsed: stopwatch.elapsed,
      isRunning: false,
      laps: state.laps,
    ));
  }

  final newLaps = [];

  void lapStopWatch() {
    newLaps.add(
        '${state.elapsed.inMinutes.toString().padLeft(2, '0')}:${(state.elapsed.inSeconds % 60).toString().padLeft(2, '0')}:${(state.elapsed.inMilliseconds % 100).toString().padLeft(2, '0')}');

    emit(StopWatchState(
      elapsed: stopwatch.elapsed,
      isRunning: true,
      laps: newLaps,
    ));
  }

  void updateTime(Timer t) {
    if (stopwatch.isRunning) {
      emit(StopWatchState(
          elapsed: stopwatch.elapsed, isRunning: true, laps: state.laps));
    }
  }

  // void recordLap() {
  //   String previousLapTime = state.currentLap;
  //   String currentLap = stopwatch.elapsed.toString().split(".")[0];
  //   String lapTimeDifference =
  //       (Duration(seconds: int.parse(currentLap.split(":")[2])) -
  //               Duration(seconds: int.parse(previousLapTime.split(":")[2])))
  //           .toString()
  //           .split(".")[0];
  //   lapTime.add('${lapTime.length + 1}:${currentLap}(+$lapTimeDifference)');
  //   emit(StopWatchState(
  //       currentLap: currentLap,
  //       lapTimeDifference: lapTimeDifference,
  //       laps: lapTime));
  // }

  void refreshStopWatch() {
    stopwatch.reset();
    state.laps.clear();

    emit(StopWatchState(
        elapsed: Duration.zero, isRunning: false, laps: state.laps));
  }
}
