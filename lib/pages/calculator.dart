// @dart = 2.12
// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smartcalculator/cubits/cubit/calculator_cubit.dart';
import 'package:smartcalculator/cubits/states/calculator_states.dart';
import 'package:smartcalculator/misc/app_strings.dart';
import 'package:smartcalculator/misc/colorstore.dart';
import 'package:smartcalculator/widgets/build_button.dart';

// ignore: must_be_immutable
class CalculatorPage extends StatelessWidget {
  CalculatorPage({Key? key}) : super(key: key);

  String equation = "";
  double result = 0;
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, CalculatorState>(
        builder: (context, state) {
      final cubit = context.read<CalculatorCubit>();

      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 0, 0, 0),
                Color.fromARGB(255, 6, 27, 37)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                      child: Column(children: [
                    Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.fromLTRB(30, 40, 15, 10),
                        child: Text(state.equation,
                            style:
                                TextStyle(fontSize: state.equationFontSize))),
                    Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.fromLTRB(10, 20, 15, 30),
                        child: Text(state.result,
                            style: TextStyle(fontSize: state.resultFontSize))),
                  ])),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        BuildButton.build("C", cubit.buttonPressed,
                            coloure: ColorStore.symbolColor),
                        BuildButton.build("%", cubit.buttonPressed,
                            coloure: ColorStore.symbolColor),
                        BuildButton.build("⌫", cubit.buttonPressed,
                            useIcon: true,
                            buttonIcon: Icons.backspace_outlined,
                            coloure: ColorStore.symbolColor),
                        BuildButton.build("÷", cubit.buttonPressed,
                            size: 40,
                            value: 15,
                            coloure: ColorStore.symbolColor),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        BuildButton.build("7", cubit.buttonPressed),
                        BuildButton.build("8", cubit.buttonPressed),
                        BuildButton.build("9", cubit.buttonPressed),
                        BuildButton.build("×", cubit.buttonPressed,
                            size: 40,
                            value: 15,
                            coloure: ColorStore.symbolColor),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        BuildButton.build("4", cubit.buttonPressed),
                        BuildButton.build("5", cubit.buttonPressed),
                        BuildButton.build("6", cubit.buttonPressed),
                        BuildButton.build("-", cubit.buttonPressed,
                            size: 50,
                            value: 8,
                            coloure: ColorStore.symbolColor),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        BuildButton.build("1", cubit.buttonPressed),
                        BuildButton.build("2", cubit.buttonPressed),
                        BuildButton.build("3", cubit.buttonPressed),
                        BuildButton.build(
                          "+",
                          cubit.buttonPressed,
                          size: 40,
                          value: 15,
                          coloure: ColorStore.symbolColor,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        BuildButton.build("00", cubit.buttonPressed),
                        BuildButton.build("0", cubit.buttonPressed),
                        BuildButton.build(".", cubit.buttonPressed),
                        BuildButton.build("=", cubit.buttonPressed,
                            size: 40,
                            value: 15,
                            coloure: ColorStore.symbolColor),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  showResult(BuildContext context) {
    final cubit = context.read();
    result = double.parse(cubit.state.result);
    try {
      return Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.fromLTRB(10, 20, 15, 30),
          child: result == result.toInt()
              ? Text(result.toInt().toString())
              : Text(cubit.state.result));
    } catch (e) {
      return const SizedBox(child: Text(AppStrings.invalidError));
    }
  }
}
