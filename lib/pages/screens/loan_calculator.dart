import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcalculator/cubits/cubit/loan_cubit.dart';
import 'package:smartcalculator/misc/app_strings.dart';
import 'package:smartcalculator/misc/colorstore.dart';
import 'package:smartcalculator/variables/loan_period.dart';
import 'package:smartcalculator/widgets/app_text.dart';
import 'package:smartcalculator/widgets/resopnsive_button.dart';

class LoanCalculator extends StatelessWidget {
  LoanCalculator({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final cubit = context.watch<LoanCubit>();

    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorStore.appBarTheme,
            title: const Text(AppStrings.loanCalculator)),
        body: Form(
          key: _formKey,
          child: Container(
              height: mediaQuery.height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [ColorStore.mainBlack, ColorStore.mainBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(children: [
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.money_rounded),
                          suffix: Text(AppStrings.amount),
                          labelText: 'Loan Amount',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Loan Amount';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          cubit.loanCalculate(
                              double.parse(value),
                              cubit.state.rate,
                              cubit.state.period,
                              cubit.state.periodType);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.percent_rounded),
                          suffix: Text(AppStrings.percentSign),
                          labelText: 'Rate',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Rate';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          cubit.loanCalculate(
                              cubit.state.loanAmount,
                              double.parse(value),
                              cubit.state.period,
                              cubit.state.periodType);
                        }),
                    DropdownButtonFormField<PeriodType>(
                      value: cubit.state.periodType,
                      onChanged: (value) {
                        cubit.loanCalculate(
                            cubit.state.loanAmount,
                            cubit.state.rate,
                            cubit.state.period,
                            value as PeriodType);
                      },
                      items: const [
                        DropdownMenuItem(
                            value: PeriodType.years,
                            child: Text(AppStrings.year)),
                        DropdownMenuItem(
                            value: PeriodType.months,
                            child: Text(AppStrings.months)),
                      ],
                      decoration: const InputDecoration(
                          labelText: 'Interest Type',
                          prefixIcon: Icon(Icons.type_specimen)),
                      validator: (value) {
                        if (value == null) {
                          return 'Please Select Interest Type';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.calendar_month),
                            suffixText: "0",
                            labelText:
                                cubit.state.periodType == PeriodType.years
                                    ? 'Years'
                                    : 'Months'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Total ${cubit.state.period}';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          cubit.loanCalculate(
                              cubit.state.loanAmount,
                              cubit.state.rate,
                              double.parse(value),
                              cubit.state.periodType);
                        }),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ResponsiveButton(
                            onPressed: () {
                              cubit.loanCalculate(
                                  cubit.state.loanAmount,
                                  cubit.state.rate,
                                  cubit.state.period,
                                  cubit.state.periodType);
                            },
                            text: "Calculate"),
                        ResponsiveButton(
                            onPressed: () {
                              cubit.state.loanAmount = 0;
                              cubit.loanCalculate(
                                  cubit.state.loanAmount,
                                  cubit.state.rate,
                                  cubit.state.period,
                                  cubit.state.periodType);
                            },
                            text: "Refresh")
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                        child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(text: "Monthly Pay"),
                            AppText(
                                text: cubit.state.monthlyPay.toStringAsFixed(2))
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(text: "Total Interest"),
                            AppText(
                                text: cubit.state.totalInterest
                                    .toStringAsFixed(2))
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(text: "Total Pay"),
                            AppText(
                                text:
                                    cubit.state.finalAmount.toStringAsFixed(2))
                          ],
                        ),
                      ),
                    ]))
                  ]),
                ),
              )),
        ));
  }
}
