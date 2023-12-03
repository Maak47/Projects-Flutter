abstract class CounterEvent {}

// class CounterInitial extends CounterEvent {}

class CounterIncrease extends CounterEvent {
  final int increment;
  CounterIncrease(this.increment);
}

class CounterDecrease extends CounterEvent {
  final int decrement;
  CounterDecrease(this.decrement);
}

class CounterValue extends CounterEvent {
  final int countIncrement;
  final int countDecrement;
  CounterValue({required this.countIncrement, required this.countDecrement});
}
