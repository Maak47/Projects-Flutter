import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';
import './screens/bottom_nav_bar.dart'; // Import the BottomNavBarScreen
import './screens/login.dart'; // Import the LoginScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(10),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          colorScheme: ColorScheme.fromSeed(
              background: Color.fromRGBO(232, 236, 226, 1),
              seedColor: Color.fromARGB(255, 142, 198, 63)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 142, 198, 63),
                foregroundColor: Colors.white,
                elevation: 20),
          ),
          appBarTheme: AppBarTheme(
            elevation: 5,
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 142, 198, 63),
            centerTitle: true,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
          ),
          useMaterial3: true),
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkIfLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BottomNavBarScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return LoginScreen();
      },
    );
  }

  Future<bool> _checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final username = prefs.getString('username');
    final password = prefs.getString('password');

    if (username != null && password != null) {
      final userExists = dummyMembers.any((member) =>
          member.username == username && member.password == password);

      return userExists;
    }

    return false;
  }
}
