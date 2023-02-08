// ignore_for_file: public_member_api_docs, sort_constructors_first

class StopWatchState {
  final Duration elapsed;
  final bool isRunning;
  final String start;
  final String stop;
  final String lap;
  String restart;
  final List laps;
  final String lapTimeDifference;

  StopWatchState(
      {this.elapsed = Duration.zero,
      this.isRunning = false,
      this.start = 'Start',
      this.stop = 'Stop',
      this.restart = 'Restart',
      this.lap = 'Lap',
      this.lapTimeDifference = '',
      this.laps = const []});
}
