import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcalculator/cubits/cubit/interest_cubit.dart';
import 'package:smartcalculator/misc/app_strings.dart';
import 'package:smartcalculator/misc/colorstore.dart';
import 'package:smartcalculator/variables/interest_type.dart';
import 'package:smartcalculator/widgets/app_text.dart';
import 'package:smartcalculator/widgets/resopnsive_button.dart';

class InterestCalculator extends StatelessWidget {
  InterestCalculator({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  String interest = 'Simple Interest';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final cubit = context.watch<InterestCubit>();

    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorStore.appBarTheme,
            title: const Text(AppStrings.interestCalculator)),
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField<InterestType>(
                          value: cubit.state.selectedInterestType,
                          onChanged: (value) {
                            cubit.setInterest(value as InterestType);
                          },
                          items: const [
                            DropdownMenuItem(
                                value: InterestType.simple,
                                child: Text(AppStrings.simpleInterest)),
                            DropdownMenuItem(
                                value: InterestType.compound,
                                child: Text(AppStrings.compoundInterest)),
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
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.money),
                              suffixText: "0",
                              labelText: 'Initial Amount',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Amount';
                              }
                              return null;
                            },
                            onChanged: (pAmount) {
                              cubit.setInterest(
                                  cubit.state.selectedInterestType);
                              cubit.interestCalculate(double.parse(pAmount),
                                  cubit.state.rate, cubit.state.time);
                            }),
                        const SizedBox(height: 20),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.percent),
                              suffix: Text(AppStrings.perYear),
                              labelText: 'Interest Rate',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Interest Rate';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              cubit.interestCalculate(
                                  cubit.state.principleAmount,
                                  double.parse(value),
                                  cubit.state.time);
                            }),
                        const SizedBox(height: 20),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.timelapse),
                              suffix: Text(AppStrings.years),
                              labelText: 'Total Years',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Total Years';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              cubit.interestCalculate(
                                  cubit.state.principleAmount,
                                  cubit.state.rate,
                                  double.parse(value));
                            }),
                        const SizedBox(height: 20),
                        const Divider(height: 20),
                        const SizedBox(height: 20),
                        cubit.state.finalAmount <= 0
                            ? const SizedBox()
                            : SizedBox(
                                child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(text: "Final Amount"),
                                      AppText(
                                          text: cubit.state.finalAmount
                                              .toStringAsFixed(2))
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(text: "Interest"),
                                      AppText(
                                          text: cubit.state
                                                      .selectedInterestType ==
                                                  InterestType.simple
                                              ? cubit.state.finalSimpleInterest
                                                  .toStringAsFixed(2)
                                              : cubit
                                                  .state.finalCompoundInterest
                                                  .toStringAsFixed(2))
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
