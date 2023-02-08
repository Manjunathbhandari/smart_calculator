import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/converter_state.dart';

class ConverterCubit extends Cubit<ConverterState> {
  final formKey = GlobalKey<FormState>();
  ConverterCubit() : super(ConverterState());

  final List<String> selectedMeasurements = [
    'Length',
    'Weight',
    'Area',
    'Temperature',
    'Volume'
  ];
  final Map<String, List<String>> units = {
    'Length': [
      'Meter',
      'MilliMeter',
      'CentiMeter',
      'DeciMeter',
      'Inche',
      'Feet',
      'Yard',
      'Mile',
    ],
    'Weight': [
      'Ounce',
      'Gram',
      'Pound',
      'Kilogram',
      'Microgram',
      'Quintal',
      'Carat',
      'Ton',
      'Milligram',
      'Grain',
      'Dram',
      'Stone',
    ],
    "Area": [
      'Square meter',
      'Square decimeter',
      'Square centimeter',
      'Square kilometer',
      'Square millimeter',
      'Are',
      'Hectare',
      'Square foot',
      'Acre',
      'Square inch',
    ],
    "Volume": [
      'Fluid Ounce',
      'Milliliter',
      'Liter',
      'Gallon',
      'Hectoliter',
      'Deciliter',
      'Centiliter',
    ],
    "Temperature": [
      'fahrenheit',
      'celsius',
      'kelvin',
    ]
  };

  void selectMeasurement(String measurement) {
    final selectedFromUnit = units[measurement]![0];
    final selectedToUnit = units[measurement]![1];
    emit(ConverterState(
        selectedMeasurement: measurement,
        selectedFromUnit: selectedFromUnit,
        selectedToUnit: selectedToUnit,
        convertedValue: 0,
        enteredValue: state.enteredValue));
  }

  void selectFromUnit(String fromUnit) {
    emit(ConverterState(
        selectedMeasurement: state.selectedMeasurement,
        selectedFromUnit: fromUnit,
        selectedToUnit: state.selectedToUnit,
        convertedValue: 0,
        enteredValue: state.enteredValue));
  }

  void selectToUnit(String toUnit) {
    emit(ConverterState(
        selectedMeasurement: state.selectedMeasurement,
        selectedFromUnit: state.selectedFromUnit,
        selectedToUnit: toUnit,
        convertedValue: 0,
        enteredValue: state.enteredValue));
  }

  void changeEnteredValue(double value) {
    emit(ConverterState(
        selectedMeasurement: state.selectedMeasurement,
        selectedFromUnit: state.selectedFromUnit,
        selectedToUnit: state.selectedToUnit,
        convertedValue: 0,
        enteredValue: value));
  }

  void convert() {
    double enteredValue = state.enteredValue;
    String selectedMeasurement = state.selectedMeasurement;
    String selectedFromUnit = state.selectedFromUnit;
    String selectedToUnit = state.selectedToUnit;

    double valueInBaseUnit = 0.0;

    if (selectedMeasurement == 'Length') {
      valueInBaseUnit = convertLength(enteredValue, selectedFromUnit);
    } else if (selectedMeasurement == 'Weight') {
      valueInBaseUnit = convertMass(enteredValue, selectedFromUnit);
    } else if (selectedMeasurement == 'Volume') {
      valueInBaseUnit = convertVolume(enteredValue, selectedFromUnit);
    } else if (selectedMeasurement == 'Temperature') {
      valueInBaseUnit = convertTemperature(enteredValue, selectedFromUnit);
    } else if (selectedMeasurement == 'Area') {
      valueInBaseUnit = convertArea(enteredValue, selectedFromUnit);
    }

    if (selectedToUnit == 'Inche') {
    } else if (selectedToUnit == 'CentiMeter') {
    } else if (selectedToUnit == 'Meter') {
    } else if (selectedToUnit == 'Feet') {
    } else if (selectedToUnit == 'Yard') {
    } else if (selectedToUnit == 'Mile') {
    } else if (selectedToUnit == 'MilliMeter') {
    } else if (selectedToUnit == 'KiloMeter') {
    } else if (selectedToUnit == 'DeciMeter') {
    } else if (selectedToUnit == 'MicroMeter') {
    } else if (selectedToUnit == 'Fathom') {
    }

    //Weight
    else if (selectedToUnit == 'Ounce') {
    } else if (selectedToUnit == 'Gram') {
    } else if (selectedToUnit == 'Pound') {
    } else if (selectedToUnit == 'Kilogram') {
    } else if (selectedToUnit == 'Microgram') {
    } else if (selectedToUnit == 'Quintal') {
    } else if (selectedToUnit == 'Carat') {
    } else if (selectedToUnit == 'Ton') {
    } else if (selectedToUnit == 'Milligram') {
    } else if (selectedToUnit == 'Grain') {
    } else if (selectedToUnit == 'Dram') {
    } else if (selectedToUnit == 'Stone') {
    }
    // Volume

    else if (selectedToUnit == 'Fluid Ounce') {
    } else if (selectedToUnit == 'Milliliters') {
    } else if (selectedToUnit == 'Liters') {
    } else if (selectedToUnit == 'Gallons') {
    } else if (selectedToUnit == 'Hectoliter') {
    } else if (selectedToUnit == 'Dciliter') {
    } else if (selectedToUnit == 'Centiliter') {
    }

    //Temperature
    else if (selectedToUnit == 'fahrenheit') {
    } else if (selectedToUnit == 'celsius') {
    } else if (selectedToUnit == 'kelvin') {
    }
    //Area
    else if (selectedToUnit == 'Square meter') {
    } else if (selectedToUnit == 'Square decimeter') {
    } else if (selectedToUnit == 'Square centimeter') {
    } else if (selectedToUnit == 'Square kilometer') {
    } else if (selectedToUnit == 'Square millimeter') {
    } else if (selectedToUnit == 'Are') {
    } else if (selectedToUnit == 'Hectare') {
    } else if (selectedToUnit == 'Square foot') {
    } else if (selectedToUnit == 'Acre') {
      (valueInBaseUnit / 40469445.57);
    }

    emit(ConverterState(
        selectedMeasurement: state.selectedMeasurement,
        selectedFromUnit: state.selectedFromUnit,
        selectedToUnit: state.selectedToUnit,
        convertedValue: valueInBaseUnit,
        enteredValue: state.enteredValue));
  }

  double convertLength(double value, String fromUnit) {
    double valueInInches = value;
    if (fromUnit == 'Inche') {
      return valueInInches * 0.0254;
    } else if (fromUnit == 'CentiMeter') {
      return valueInInches * 0.01;
    } else if (fromUnit == 'Meter') {
      return valueInInches;
    } else if (fromUnit == 'Feet') {
      return valueInInches * 0.3048;
    } else if (fromUnit == 'Yard') {
      return valueInInches * 0.9143;
    } else if (fromUnit == 'Mile') {
      return valueInInches * 1609.27;
    } else if (fromUnit == 'MilliMeter') {
      return valueInInches * 0.001;
    } else if (fromUnit == 'KiloMeter') {
      return valueInInches * 1000;
    } else if (fromUnit == 'DeciMeter') {
      return valueInInches * 0.1;
    } else if (fromUnit == 'MicroMeter') {
      return valueInInches * 0.000001;
    } else if (fromUnit == 'Fathom') {
      return valueInInches * 1.8288;
    } else {
      return 0.0;
    }
  }

  double convertMass(double value, String fromUnit) {
    double valueInGrams = value;
    if (fromUnit == 'Ounce') {
      return valueInGrams * 28.35;
    } else if (fromUnit == 'Gram') {
      return valueInGrams;
    } else if (fromUnit == 'Pound') {
      return valueInGrams * 453.59;
    } else if (fromUnit == 'Kilogram') {
      return valueInGrams * 182.88;
    } else if (fromUnit == 'Microgram') {
      return valueInGrams * 0.000001;
    } else if (fromUnit == 'Quintal') {
      return valueInGrams * 100000;
    } else if (fromUnit == 'Carat') {
      return valueInGrams * 0.2;
    } else if (fromUnit == 'Ton') {
      return valueInGrams * 1000000;
    } else if (fromUnit == 'Milligram') {
      return valueInGrams * 0.001;
    } else if (fromUnit == 'Grain') {
      return valueInGrams * 0.0648;
    } else if (fromUnit == 'Dram') {
      return valueInGrams * 1.771;
    } else if (fromUnit == 'Ston') {
      return valueInGrams * 6350.29;
    } else {
      return 0.0;
    }
  }

  double convertVolume(double value, String fromUnit) {
    double valueInMilliliters = value;
    if (fromUnit == 'Fluid Ounce') {
      return valueInMilliliters * 29.57;
    } else if (fromUnit == 'Milliliter') {
      return valueInMilliliters;
    } else if (fromUnit == 'Liter') {
      return valueInMilliliters * 1000;
    } else if (fromUnit == 'Gallon') {
      return valueInMilliliters * 3785.41;
    } else {
      return 0.0;
    }
  }

  double convertTemperature(double value, String fromUnit) {
    double valueInCelsius = value;
    if (fromUnit == 'fahrenheit') {
      return (valueInCelsius - 32) * 5 / 9;
    } else if (fromUnit == 'celsius') {
      return valueInCelsius;
    } else if (fromUnit == 'kelvin') {
      return valueInCelsius - 273.15;
    } else {
      return 0.0;
    }
  }

  double convertArea(double value, String fromUnit) {
    double valueInSquareCentimeter = value;
    if (fromUnit == 'Square meter') {
      return (valueInSquareCentimeter * 10000);
    } else if (fromUnit == 'Square decimeter') {
      return (valueInSquareCentimeter * 100);
    } else if (fromUnit == 'Square centimeter') {
      return (valueInSquareCentimeter);
    } else if (fromUnit == 'Square kilometer') {
      return (valueInSquareCentimeter * 10000000000);
    } else if (fromUnit == 'Square millimeter') {
      return (valueInSquareCentimeter * 0.01);
    } else if (fromUnit == 'Are') {
      return (valueInSquareCentimeter * 1000000);
    } else if (fromUnit == 'Hectare') {
      return (valueInSquareCentimeter * 100000000);
    } else if (fromUnit == 'Square foot') {
      return (valueInSquareCentimeter * 929.03);
    } else if (fromUnit == 'Acre') {
      return (valueInSquareCentimeter * 40469445.57);
    } else {
      return 0.0;
    }
  }
}
