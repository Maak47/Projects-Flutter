import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'internet__event.dart';
part 'internet__state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  InternetBloc() : super(InternetInitial()) {
    on<InternetEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
