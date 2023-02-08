import 'package:flutter/material.dart';
import 'package:smartcalculator/misc/colorstore.dart';
import 'package:smartcalculator/pages/calculator.dart';
import 'package:smartcalculator/pages/converter.dart';
import 'package:smartcalculator/pages/moretools.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final tabs = const [
    Tab(text: "Calculator"),
    Tab(text: "Converter"),
    Tab(text: "More")
  ];

  final tabPage = [
    CalculatorPage(),
    const UnitConverter(),
    const MoreToolsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: ColorStore.lightBlack,
                title: TabBar(
                  labelColor: Colors.white,
                  tabs: tabs,
                  indicatorColor: Colors.indigo,
                )),
            body: TabBarView(children: tabPage)));
  }
}
