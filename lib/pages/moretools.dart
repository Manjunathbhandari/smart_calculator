import 'package:flutter/material.dart';
import 'package:smartcalculator/pages/screens/age_calculator.dart';
import 'package:smartcalculator/pages/screens/bmi_calculator.dart';
import 'package:smartcalculator/pages/screens/interes_calculator.dart';
import 'package:smartcalculator/pages/screens/loan_calculator.dart';
import 'package:smartcalculator/pages/screens/primechecker.dart';
import 'package:smartcalculator/pages/screens/stopwatch.dart';
import 'package:smartcalculator/widgets/card_view.dart';

class MoreToolsPage extends StatelessWidget {
  const MoreToolsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          CustomCard(
              text: "BMI Calculator",
              onPressed: () =>
                  Navigator.push(context, SlideTransitions(BMICalculator()))),
          const SizedBox(height: 15),
          CustomCard(
              text: "Age Calculator",
              onPressed: () => Navigator.push(
                  context, SlideTransitions(const AgeCalculator()))),
          const SizedBox(height: 15),
          CustomCard(
              text: "Interest Calculator",
              onPressed: () => Navigator.push(
                  context, SlideTransitions(InterestCalculator()))),
          const SizedBox(height: 15),
          CustomCard(
              text: "Stop Watch",
              onPressed: () =>
                  Navigator.push(context, SlideTransitions(const StopWatch()))),
          const SizedBox(height: 15),
          CustomCard(
              text: "Prime Checker",
              onPressed: () => Navigator.push(
                  context, SlideTransitions(const PrimeChecker()))),
          const SizedBox(height: 15),
          CustomCard(
              text: "Loan Calulator",
              onPressed: () =>
                  Navigator.push(context, SlideTransitions(LoanCalculator()))),
          const SizedBox(height: 15),
        ]),
      ),
    ));
  }
}

class SlideTransitions extends PageRouteBuilder {
  final Widget page;
  SlideTransitions(this.page)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: const Duration(milliseconds: 1500),
            reverseTransitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  parent: animation,
                  reverseCurve: Curves.fastOutSlowIn);
              return SlideTransition(
                  position: Tween(
                          begin: const Offset(1.0, 1.0),
                          end: const Offset(0.0, 0.0))
                      .animate(animation),
                  child: page);
            });
}
