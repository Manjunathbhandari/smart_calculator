import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcalculator/cubits/cubit/prime_cubit.dart';
import 'package:smartcalculator/misc/app_strings.dart';
import 'package:smartcalculator/misc/colorstore.dart';
import 'package:smartcalculator/widgets/app_text.dart';
import 'package:smartcalculator/widgets/resopnsive_button.dart';

import '../../cubits/states/prime_state.dart';

class PrimeChecker extends StatelessWidget {
  const PrimeChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return BlocBuilder<PrimeCubit, PrimeState>(builder: (context, state) {
      final cubit = context.watch<PrimeCubit>();
      return Scaffold(
          appBar: AppBar(title: const Text(AppStrings.primeChecker)),
          body: Container(
              height: mediaQuery.height,
              width: mediaQuery.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [ColorStore.mainBlack, ColorStore.mainBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(children: [
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.confirmation_number),
                          suffixText: "0",
                          labelText: 'Number',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          cubit.checkPrime(int.parse(value));
                        }),
                    const SizedBox(height: 20),
                    ResponsiveButton(
                        onPressed: () => cubit.checkPrime, text: "Check"),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(text: "Is Prime?"),
                              AppText(text: cubit.state.isPrime ? "Yes" : "No")
                            ]),
                        const Divider(height: 40),
                        if (cubit.state.isPrime != true)
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(text: "Next Prime"),
                                AppText(text: cubit.state.nextPrime.toString())
                              ])
                      ],
                    )
                  ]))));
    });
  }
}
