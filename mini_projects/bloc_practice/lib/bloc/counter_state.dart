abstract class CounterState {}

class CounterChangeState extends CounterState {
  final int count;

  CounterChangeState(this.count);
}

class CounterInputState extends CounterState {
  final int counterInput;

  CounterInputState(this.counterInput);
}
