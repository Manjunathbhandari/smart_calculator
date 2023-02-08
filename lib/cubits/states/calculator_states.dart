// ignore_for_file: public_member_api_docs, sort_constructors_first
class CalculatorState {
  final String equation;
  final String result;
  final String expression;
  final double equationFontSize;
  final double resultFontSize;
  late final String secretKey;

  CalculatorState(
      {this.equation = '',
      this.result = '',
      this.expression = '',
      this.equationFontSize = 38.0,
      this.resultFontSize = 48.0,
      this.secretKey = ''});
}
