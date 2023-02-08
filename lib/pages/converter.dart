import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcalculator/cubits/cubit/converter_cubit.dart';
import 'package:smartcalculator/widgets/app_text.dart';
import 'package:smartcalculator/widgets/resopnsive_button.dart';

import '../cubits/states/converter_state.dart';

class UnitConverter extends StatelessWidget {
  const UnitConverter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConverterCubit, ConverterState>(
        builder: (context, state) {
      final cubit = context.watch<ConverterCubit>();
      return Form(
        key: cubit.formKey,
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  DropdownButtonFormField(
                    value: cubit.state.selectedMeasurement,
                    items: cubit.selectedMeasurements.map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                    onChanged: (value) {
                      cubit.selectMeasurement(value.toString());
                      cubit.convert();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Measurement',
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a measurement';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  DropdownButtonFormField(
                    value: cubit.state.selectedFromUnit,
                    items: cubit.units[cubit.state.selectedMeasurement]
                        ?.map((unit) {
                      return DropdownMenuItem(value: unit, child: Text(unit));
                    }).toList(),
                    onChanged: (value) {
                      cubit.selectMeasurement(cubit.state.selectedMeasurement);
                      cubit.selectFromUnit(value.toString());
                      cubit.convert();
                    },
                    decoration: const InputDecoration(
                      labelText: 'From unit',
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a unit';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  DropdownButtonFormField(
                    value: cubit.state.selectedToUnit,
                    items: cubit.units[cubit.state.selectedMeasurement]
                        ?.map((unit) {
                      return DropdownMenuItem(value: unit, child: Text(unit));
                    }).toList(),
                    onChanged: (value) {
                      cubit.selectMeasurement(cubit.state.selectedMeasurement);
                      cubit.selectToUnit(value.toString());
                      cubit.convert();
                    },
                    decoration: const InputDecoration(
                      labelText: 'To unit',
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a unit';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      cubit.selectMeasurement(cubit.state.selectedMeasurement);
                      cubit.changeEnteredValue(double.parse(value));
                      cubit.convert();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Value',
                    ),
                  ),
                  const SizedBox(height: 25.0),

                  ResponsiveButton(
                      text: "Convert",
                      onPressed: () {
                        cubit.convert();
                      }),
                  const SizedBox(height: 16.0),
                  // ignore: unrelated_type_equality_checks
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(text: cubit.state.selectedFromUnit),
                              AppText(text: cubit.state.enteredValue.toString())
                            ]),
                        const Divider(height: 30),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(text: cubit.state.selectedToUnit),
                              AppText(
                                  text: cubit.state.convertedValue.toString())
                            ]),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
