import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:smartcalculator/cubits/states/calculator_states.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorState());

  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      emit(CalculatorState(
          equation: "",
          result: "",
          equationFontSize: 38.0,
          resultFontSize: 48.0));
    } else if (buttonText == "⌫") {
      emit(CalculatorState(
          equationFontSize: 48.0,
          resultFontSize: 38.0,
          equation: state.equation.substring(0, state.equation.length - 1),
          result: ""));
    } else if (buttonText == '%') {
      double res = double.parse(state.result);
      emit(CalculatorState(result: (res / 100).toString()));
    } else if (buttonText == "=") {
      String expression = state.equation;
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');

      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);

        ContextModel cm = ContextModel();
        String result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        if (result.endsWith('.0')) {
          result = result.substring(0, result.length - 2);
        }
        emit(CalculatorState(
            equation: state.equation,
            result: result,
            equationFontSize: 38.0,
            resultFontSize: 48.0));
      } catch (e) {
        if (state.result == '') {
          emit(CalculatorState(
            equation: '0',
            result: '0',
            equationFontSize: 38,
            resultFontSize: 48,
          ));
        } else {
          emit(CalculatorState(
            equation: state.equation,
            result: "Invalid Input",
            equationFontSize: 38,
            resultFontSize: 48,
          ));
        }
      }
    } else {
      emit(CalculatorState(
          equation: state.equation + buttonText,
          result: "",
          equationFontSize: 48,
          resultFontSize: 38));
    }
  }
}
