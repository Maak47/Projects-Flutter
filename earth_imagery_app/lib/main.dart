import 'package:earth_imagery_app/screens/auth.dart';
import 'package:earth_imagery_app/widgets/bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(centerTitle: true),
        textTheme: GoogleFonts.latoTextTheme(Typography.whiteMountainView),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color.fromARGB(255, 36, 28, 71)),
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
            brightness: Brightness.dark,
            background: Color.fromARGB(255, 36, 28, 71)
            // primarySwatch: Colors.purple,
            // accentColor: Color.fromARGB(255, 84, 59, 130),
            ),
      ),
      home:
          //  AuthScreen(),
          BottomNav(
        updateCurrentIndex: 0,
      ),
    );
  }
}
