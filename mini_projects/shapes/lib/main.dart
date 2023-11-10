import 'package:flutter/material.dart';

import './screens/navigation.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
            useMaterial3: true,
      ),
      home: const NavigationScreen(),
    );
  }
}
