// ignore_for_file: public_member_api_docs, sort_constructors_first

class PrimeState {
  final bool isPrime;
  final int? nextPrime;

  PrimeState({
    required this.isPrime,
    this.nextPrime,
  });

  factory PrimeState.initial() => PrimeState(isPrime: false);

  PrimeState copyWith({
    bool? isPrime,
    int? nextPrime,
  }) {
    return PrimeState(
      isPrime: isPrime ?? this.isPrime,
      nextPrime: nextPrime ?? this.nextPrime,
    );
  }
}
