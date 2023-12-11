import 'package:bloc/bloc.dart';
import 'package:bloc_practice_infinite_list/app.dart';
import 'package:bloc_practice_infinite_list/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(App());
}
