import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            )),
        colorScheme: ColorScheme.fromSwatch(
            backgroundColor: Colors.white, accentColor: Colors.black),
      ),
      title: 'Scribbles',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Scribbles'),
        ),
        body: Center(child: Text('Home')),
      ),
    );
  }
}
