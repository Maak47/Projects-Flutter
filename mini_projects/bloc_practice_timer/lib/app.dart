import 'package:bloc_practice_timer/timer/view/timer_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Practice Timer',
      theme: ThemeData(
          colorScheme: ColorScheme.light(
        primary: Color.fromRGBO(72, 74, 126, 1),
      )),
      home: const TimerPage(),
    );
  }
}
