import 'package:flutter_bloc/flutter_bloc.dart';
import './internet__event.dart';
import './internet__state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  InternetBloc() : super(InternetInitial()) {
    on<InternetEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
