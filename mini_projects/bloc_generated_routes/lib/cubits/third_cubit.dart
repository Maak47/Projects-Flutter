import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdCubit extends Cubit<int> {
  ThirdCubit() : super(0);

  void increment () => emit(state + 1);
}