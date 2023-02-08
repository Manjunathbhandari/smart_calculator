import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcalculator/cubits/states/loan_state.dart';
import 'package:smartcalculator/variables/loan_period.dart';

class LoanCubit extends Cubit<LoanState> {
  LoanCubit() : super(LoanState());

  void loanCalculate(
      double loanAmount, double rate, double period, PeriodType periodType) {
    double periodInMonths =
        periodType == PeriodType.years ? period * 12 : period;
    double monthlyPay = (loanAmount *
            (rate / 100 / 12) *
            pow(1 + (rate / 100 / 12), periodInMonths)) /
        (pow(1 + (rate / 100 / 12), periodInMonths) - 1);
    double totalInterest = monthlyPay * periodInMonths - loanAmount;
    double totalAmount = monthlyPay * periodInMonths;
    emit(LoanState(
        loanAmount: loanAmount,
        rate: rate,
        period: period,
        periodType: periodType,
        monthlyPay: monthlyPay,
        totalInterest: totalInterest,
        finalAmount: totalAmount));
  }
}
