// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:smartcalculator/variables/interest_type.dart';

class InterestState {
  InterestType selectedInterestType;
  double principleAmount;
  double rate;
  double time;
  double finalSimpleInterest;
  double finalCompoundInterest;
  double finalAmount;
  InterestState({
    this.selectedInterestType = InterestType.simple,
    this.principleAmount = 0.0,
    this.rate = 0.0,
    this.time = 0.0,
    this.finalSimpleInterest = 0.0,
    this.finalCompoundInterest = 0.0,
    this.finalAmount = 0.0,
  });

  InterestState copyWith({
    InterestType? selectedInterestType,
    double? principleAmount,
    double? rate,
    double? time,
    double? finalSimpleInterest,
    double? finalCompoundInterest,
    double? finalAmount,
  }) {
    return InterestState(
      selectedInterestType: selectedInterestType ?? this.selectedInterestType,
      principleAmount: principleAmount ?? this.principleAmount,
      rate: rate ?? this.rate,
      time: time ?? this.time,
      finalSimpleInterest: finalSimpleInterest ?? this.finalSimpleInterest,
      finalCompoundInterest:
          finalCompoundInterest ?? this.finalCompoundInterest,
      finalAmount: finalAmount ?? this.finalAmount,
    );
  }
}
