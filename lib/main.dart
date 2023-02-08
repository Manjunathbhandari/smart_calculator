import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcalculator/cubits/cubit/interest_cubit.dart';
import 'package:smartcalculator/cubits/cubit/calculator_cubit.dart';
import 'package:smartcalculator/cubits/cubit/converter_cubit.dart';
import 'package:smartcalculator/cubits/cubit/loan_cubit.dart';
import 'package:smartcalculator/cubits/cubit/prime_cubit.dart';
import 'package:smartcalculator/cubits/cubit/stopwatch_cubit.dart';
import 'package:smartcalculator/cubits/cubit/test_cubit.dart';
import 'package:smartcalculator/home_page.dart';

import 'cubits/cubit/bmi_cubit.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => CalculatorCubit()),
    BlocProvider(create: (context) => ConverterCubit()),
    BlocProvider(create: (context) => BMICubit()),
    BlocProvider(create: (context) => InterestCubit()),
    BlocProvider(create: (context) => StopWatchCubit()),
    BlocProvider(create: (context) => PrimeCubit()),
    BlocProvider(create: (context) => LoanCubit()),
    BlocProvider(create: (context) => StopTestCubit()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Calculator',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
