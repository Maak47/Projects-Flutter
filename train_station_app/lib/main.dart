import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:train_station_app/models/station.dart';
import 'package:train_station_app/screens/home.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(StationAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Train Station App',
      theme: ThemeData(
        textTheme: GoogleFonts.ralewayTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
