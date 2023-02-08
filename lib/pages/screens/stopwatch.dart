import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcalculator/cubits/cubit/stopwatch_cubit.dart';
import 'package:smartcalculator/cubits/states/stopwatch_state.dart';
import 'package:smartcalculator/misc/app_strings.dart';
import 'package:smartcalculator/misc/colorstore.dart';
import 'package:smartcalculator/widgets/resopnsive_button.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch>
    with SingleTickerProviderStateMixin {
  List newLaps = [];
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return BlocBuilder<StopWatchCubit, StopWatchState>(
        builder: (context, state) {
      final cubit = context.watch<StopWatchCubit>();
      return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorStore.appBarTheme,
            title: const Text(AppStrings.stopWatch)),
        body: Container(
          height: mediaQuery.height,
          width: mediaQuery.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [ColorStore.mainBlack, ColorStore.mainBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 350,
                        child: Text(
                            '${cubit.state.elapsed.inMinutes.toString().padLeft(2, '0')}:${(cubit.state.elapsed.inSeconds % 60).toString().padLeft(2, '0')}:${(cubit.state.elapsed.inMilliseconds % 100).toString().padLeft(2, '0')}',
                            style: const TextStyle(fontSize: 30)),
                      ),
                      Positioned.fill(
                          child: CustomPaint(painter: CircleProgress()))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                          itemCount: cubit.state.laps.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CircleAvatar(
                                        radius: 18,
                                        child: Text(
                                            (state.laps.length - index)
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 20)),
                                      ),
                                      Text(
                                        cubit.state.laps.reversed
                                            .toList()[index],
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ]),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            );
                          }),
                    )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        cubit.stopwatch.isRunning
                            ? ResponsiveButton(
                                onPressed: cubit.stopStopWatch,
                                text: cubit.state.stop)
                            : ResponsiveButton(
                                onPressed: cubit.startStopWatch,
                                text: cubit.state.start),
                        const SizedBox(height: 20),
                        cubit.stopwatch.isRunning
                            ? ResponsiveButton(
                                onPressed: cubit.lapStopWatch,
                                text: cubit.state.lap)
                            : ResponsiveButton(
                                onPressed: cubit.refreshStopWatch,
                                text: cubit.state.restart),
                      ]),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class CircleProgress extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    Offset center = size.center(Offset.zero);
    double radius = min(size.width, size.height) / 2;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
