import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartcalculator/misc/app_strings.dart';
import 'package:smartcalculator/misc/colorstore.dart';
import 'package:smartcalculator/widgets/resopnsive_button.dart';

class AgeCalculator extends StatefulWidget {
  const AgeCalculator({Key? key}) : super(key: key);

  @override
  State<AgeCalculator> createState() => _AgeCalculatorState();
}

class _AgeCalculatorState extends State<AgeCalculator> {
  final _formKey = GlobalKey<FormState>();
  String _age = '';
  String _nextBirthday = '';
  final dbController = TextEditingController();
  final currentDateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedCurrentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dbController.text = DateFormat.yMMMMd().format(_selectedDate);
      });
    }
  }

  Future<void> _selectCurrentDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedCurrentDate,
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2500),
    );
    if (picked != null && picked != _selectedCurrentDate) {
      setState(() {
        _selectedCurrentDate = picked;
        currentDateController.text =
            DateFormat.yMMMMd().format(_selectedCurrentDate);
      });
    }
  }

  void _calculateAge() {
    // Calculate age
    final DateTime currentDate = DateTime.now();
    final int age = currentDateController.text == ''
        ? currentDate.year - _selectedDate.year
        : _selectedCurrentDate.year - _selectedDate.year;
    final int month1 = currentDate.month;
    final int month2 = _selectedDate.month;
    final int day1 = currentDate.day;
    final int day2 = _selectedDate.day;
    if (month2 > month1 || (month2 == month1 && day2 > day1)) {
      setState(() {
        _age = '${age - 1} years old';
      });
    } else {
      setState(() {
        _age = '$age years old';
      });
    }

    // Calculate next birthday
    final DateTime nextBirthday = DateTime(
        _selectedDate.year + age, _selectedDate.month, _selectedDate.day);
    if (nextBirthday.isBefore(currentDate)) {
      setState(() {
        _nextBirthday = DateFormat.yMMMMd()
            .format(nextBirthday.add(const Duration(days: 365)));
      });
    } else {
      setState(() {
        _nextBirthday = DateFormat.yMMMMd().format(nextBirthday);
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    dbController.dispose();
    currentDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorStore.appBarTheme,
        title: const Text(AppStrings.ageCalculator),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [ColorStore.mainBlack, ColorStore.mainBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  controller: dbController,
                  keyboardType: TextInputType.none,
                  decoration: InputDecoration(
                      labelText: "Birth Date",
                      hintText: DateFormat.yMMMMd()
                          .format(DateTime(1900, 1))
                          .toString(),
                      suffixIcon: const Icon(Icons.calendar_today)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Current Date';
                    }
                    return null;
                  },
                  onTap: () {
                    _selectDate(context);
                  }),
              const SizedBox(height: 20.0),
              TextFormField(
                  controller: currentDateController,
                  keyboardType: TextInputType.none,
                  decoration: InputDecoration(
                      labelText: "Current Date",
                      hintText:
                          DateFormat.yMMMMd().format(DateTime.now()).toString(),
                      suffixIcon: const Icon(Icons.calendar_today)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Current Date';
                    }
                    return null;
                  },
                  onTap: () {
                    _selectCurrentDate(context);
                  }),
              const SizedBox(height: 20.0),
              ResponsiveButton(
                onPressed: _calculateAge,
                text: "Calculate",
                width: 120,
              ),
              const SizedBox(height: 30.0),
              _age == ''
                  ? const SizedBox()
                  : SizedBox(
                      child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(AppStrings.age,
                                style: TextStyle(fontSize: 20)),
                            Text(_age, style: const TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(AppStrings.nextBirthday,
                                style: TextStyle(fontSize: 20)),
                            Text(_nextBirthday,
                                style: const TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ])),
            ],
          ),
        ),
      ),
    );
  }
}
