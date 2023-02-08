// ignore_for_file: public_member_api_docs, sort_constructors_first
class ConverterState {
  String selectedMeasurement;
  String selectedFromUnit;
  String selectedToUnit;
  double enteredValue;
  double convertedValue;

  ConverterState(
      {this.selectedMeasurement = 'Length',
      this.selectedFromUnit = 'Meter',
      this.selectedToUnit = 'MilliMeter',
      this.enteredValue = 0,
      this.convertedValue = 0.0});
}
