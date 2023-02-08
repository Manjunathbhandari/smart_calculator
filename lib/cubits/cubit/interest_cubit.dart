import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcalculator/cubits/states/interest_state.dart';
import 'package:smartcalculator/variables/interest_type.dart';

class InterestCubit extends Cubit<InterestState> {
  InterestCubit() : super(InterestState());

  void setInterest(InterestType interestType) {
    emit(state.copyWith(selectedInterestType: interestType));
  }

  void interestCalculate(double principleAmount, double rate, double time) {
    double finalAmount;
    double finalSimpleInterest;
    double finalCompoundInterest;
    if (state.selectedInterestType == InterestType.simple) {
      finalSimpleInterest = (principleAmount * rate * time) / 100;
      finalAmount = finalSimpleInterest + principleAmount;
      emit(state.copyWith(
        principleAmount: principleAmount,
        rate: rate,
        time: time,
        finalSimpleInterest: finalSimpleInterest,
        finalAmount: finalAmount,
      ));
    } else {
      finalCompoundInterest =
          principleAmount * (pow((1 + rate / 100), time) - 1);
      finalAmount = finalCompoundInterest + principleAmount;
      emit(state.copyWith(
          principleAmount: principleAmount,
          rate: rate,
          time: time,
          finalCompoundInterest: finalCompoundInterest,
          finalAmount: finalAmount));
    }
  }
}
