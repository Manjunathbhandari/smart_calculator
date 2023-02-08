import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcalculator/cubits/states/prime_state.dart';

class PrimeCubit extends Cubit<PrimeState> {
  PrimeCubit() : super(PrimeState.initial());

  bool isPrime(int number) {
    if (number <= 1) return false;
    int limit = sqrt(number).floor();
    for (int i = 2; i <= limit; i++) {
      if (number % i == 0) {
        return false;
      }
    }
    return true;
  }

  int nextPrime(int number) {
    while (true) {
      number++;
      if (isPrime(number)) return number;
    }
  }

  void checkPrime(int primeValue) {
    if (isPrime(primeValue)) {
      emit(state.copyWith(isPrime: true));
    } else {
      int nextPrimeNumber = nextPrime(primeValue);
      emit(state.copyWith(isPrime: true, nextPrime: nextPrimeNumber));
    }
  }
}
