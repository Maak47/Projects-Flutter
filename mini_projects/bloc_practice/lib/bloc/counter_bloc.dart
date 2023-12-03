import 'dart:async';

import 'package:bloc_practice/bloc/counter_event.dart';
import 'package:bloc_practice/bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
   int incrementValue;
   int decrementValue;
  CounterBloc({required this.incrementValue, required this.decrementValue})
      : super(CounterChangeState(0)) {
    on<CounterValue>(counterValue);
    on<CounterIncrease>(counterIncrease);
    on<CounterDecrease>(counterDecrease);
  }

  FutureOr<void> counterIncrease(
      CounterIncrease event, Emitter<CounterState> emit) {
    emit(CounterChangeState( state. + 1));
  }

  FutureOr<void> counterDecrease(
      CounterDecrease event, Emitter<CounterState> emit) {
    emit(CounterChangeState(state.count + 1));
  }

  FutureOr<void> counterValue(CounterValue event, Emitter<CounterState> emit) {
    incrementValue = event.countIncrement;
    decrementValue = event.countDecrement;
  }
}
