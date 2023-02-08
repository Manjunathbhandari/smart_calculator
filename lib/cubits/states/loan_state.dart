import 'package:smartcalculator/variables/loan_period.dart';

class LoanState {
  double loanAmount;
  final double rate;
  final double period;
  final PeriodType periodType;
  final double monthlyPay;
  final double totalInterest;
  final double finalAmount;
  LoanState(
      {this.loanAmount = 0,
      this.rate = 0,
      this.period = 0,
      this.periodType = PeriodType.years,
      this.monthlyPay = 0,
      this.totalInterest = 0,
      this.finalAmount = 0});
}
