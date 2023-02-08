import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcalculator/cubits/states/bmi_state.dart';

class BMICubit extends Cubit<BMIState> {
  BMICubit() : super(BMIState());
  double _weight = 0.0;
  double _height = 0.0;
  double _age = 0.0;

  void setGender(String gender) {
    emit(BMIState(gender: gender));
  }

  void setHeight(double height) {
    emit(BMIState(height: height));
    _height = height;
  }

  void setAge(double age) {
    emit(BMIState(age: age));
    _age = age;
  }

  void setWeight(double weight) {
    emit(BMIState(weight: weight));
    _weight = weight;
  }

  Future<void> bmiCalculator() async {
    final double bmi, fatPercent, idealWeight;
    bmi = _weight / ((_height / 100) * (_height / 100));
    fatPercent = (1.2 * state.bmi) +
        (0.23 * _age) -
        // ignore: unrelated_type_equality_checks
        (state.gender == 'Male' ? 1 * 10.8 : 0 * 10.8) -
        5.4;
    idealWeight = (_height / 100) * (_height / 100) * 22;
    emit(BMIState(bmi: bmi, fatPercent: fatPercent, idealWeight: idealWeight));
  }
}
