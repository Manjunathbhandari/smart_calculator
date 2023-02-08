// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcalculator/misc/app_strings.dart';
import 'package:smartcalculator/misc/colorstore.dart';
import 'package:smartcalculator/widgets/app_text.dart';
import 'package:smartcalculator/widgets/resopnsive_button.dart';
import '../../cubits/cubit/bmi_cubit.dart';
import '../../cubits/states/bmi_state.dart';

class BMICalculator extends StatelessWidget {
  BMICalculator({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final genders = ["Male", "Female"];
  String gender = '';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return BlocBuilder<BMICubit, BMIState>(builder: (context, state) {
      final cubit = context.read<BMICubit>();
      if (gender == '' || gender == 'Male') {
        gender = 'Male';
      } else {
        gender = 'Female';
      }
      return Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: ColorStore.appBarTheme,
              title: const Text(AppStrings.bmiTitle)),
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
                      DropdownButtonFormField(
                        value: gender,
                        items: genders.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          prefixIcon: state.gender == 'Male'
                              ? const Icon(Icons.male)
                              : const Icon(Icons.female),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please Select Your Gender';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          cubit.setGender(value.toString());
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.confirmation_number),
                            suffixText: "0",
                            labelText: 'Age',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Age';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            cubit.setAge(double.parse(value));
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.height),
                            suffix: Text(AppStrings.cm),
                            labelText: 'Height',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Height';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            cubit.setHeight(double.parse(value));
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.monitor_weight),
                            suffix: Text(AppStrings.kg),
                            labelText: 'Weight',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Weight';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            cubit.setWeight(double.parse(value));
                          }),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ResponsiveButton(
                              onPressed: cubit.bmiCalculator,
                              text: "Calculate"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      state.bmi != 0
                          ? SizedBox(
                              child: Column(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(text: "Mass Index"),
                                    AppText(text: state.bmi.toStringAsFixed(2))
                                  ],
                                ),
                              ),
                              const Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(text: "Fat Percentage"),
                                    AppText(
                                        text:
                                            state.fatPercent.toStringAsFixed(2))
                                  ],
                                ),
                              ),
                              const Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(text: "Ideal Weight"),
                                    AppText(
                                        text: state.idealWeight
                                            .toStringAsFixed(2))
                                  ],
                                ),
                              ),
                            ]))
                          : SizedBox()
                    ]),
                  ),
                )),
          ));
    });
  }
}
