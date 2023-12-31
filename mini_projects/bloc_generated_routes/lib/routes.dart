import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubits.dart';
import '../screens/screens.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/first':
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => FirstCubit(),
                  child: const FirstScreen(),
                ));
      case '/second':
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SecondCubit(),
                  child: SecondScreen(
                    title: arguments['title'],
                  ),
                ));
      case '/third':
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ThirdCubit(),
                  child: const ThirdScreen(),
                ));
      default:
        return null;
    }
  }
}
