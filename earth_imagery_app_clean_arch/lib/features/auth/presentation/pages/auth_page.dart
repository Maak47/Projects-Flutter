import 'dart:convert';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:earth_imagery_app_clean_arch/configs/constants/constants.dart';
import 'package:earth_imagery_app_clean_arch/features/auth/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/user_model.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final constants = AppConstants();
  bool onAuth = false;
  bool onLogin = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _saveUser(String username, String password) async {
    final usersBox = await Hive.openBox<UserModel>('users');
    final user =
        UserModel(username: username, passwordHash: _hashPassword(password));
    usersBox.put(username, user);
  }

  UserModel? _getUserByUsername(String username) {
    final usersBox = Hive.box<UserModel>('users');
    return usersBox.get(username);
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  void _login() {
    final storedUser = _getUserByUsername(usernameController.text);
    if (storedUser != null &&
        storedUser.passwordHash == _hashPassword(passwordController.text)) {
      // Login successful, show success SnackBar
      _showSnackBar('Login successful', Colors.grey, Colors.white);
      // Navigate to the Main Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(username: usernameController.text),
        ),
      );
    } else {
      // Invalid credentials, show error SnackBar
      _showSnackBar('Invalid credentials', Colors.red, Colors.white);
      print('Invalid credentials');
    }
  }

  void _showSnackBar(String message, Color backgroundColor, Color textColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/auth_image.jpg', // Replace with your image URL
            fit: BoxFit.cover,
          ),

          // Blurred Background
          if (onAuth)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),

          // Buttons
          if (!onAuth)
            Positioned(
              top: 130,
              left: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Earth',
                      style: TextStyle(
                          color: constants.kPrimaryColor,
                          fontSize: 90,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Visor',
                      style:
                          TextStyle(color: constants.kTextColor, fontSize: 75),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            bottom: 20.0,
            left: 16.0,
            right: 16.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!onAuth)
                  SizedBox(
                    width: 235,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          onAuth = true;
                          onLogin = true;
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: constants.kTextColor,
                        backgroundColor: constants.kPrimaryColor,
                        padding: const EdgeInsets.all(16.0),
                      ),
                      child: const Text('Login'),
                    ),
                  ),
              ],
            ),
          ),

          // Auth Card
          if (onAuth)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter Your Credentials.',
                    style: TextStyle(
                      color: constants.kTextColor,
                      fontSize: 25,
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    margin: const EdgeInsets.all(20.0),
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: usernameController,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                filled:
                                    true, // Set to true to fill the background
                                fillColor: const Color(0xff2EC4B6),
                                alignLabelWithHint:
                                    true, // Center-align the label

                                labelText: 'Username',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                      color: Color(0xff2EC4B6), width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                      color: Color(0xff2EC4B6), width: 1.0),
                                ),
                                prefixIcon: const Icon(Icons.person_rounded)),
                          ),
                          const SizedBox(height: 16.0),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                filled:
                                    true, // Set to true to fill the background
                                fillColor: const Color(0xff2EC4B6),
                                alignLabelWithHint:
                                    true, // Center-align the label

                                labelText: 'Password',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                      color: Color(0xff2EC4B6), width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                      color: Color(0xff2EC4B6), width: 1.0),
                                ),
                                prefixIcon: const Icon(Icons.lock)),
                          ),
                          const SizedBox(height: 50.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: const BorderSide(
                                      color: Color(0xff2EC4B6))),
                              backgroundColor: Colors.transparent,
                              foregroundColor: constants.kPrimaryColor,
                              padding: const EdgeInsets.all(16.0),
                            ),
                            onPressed: () {
                              if (onLogin) {
                                // Log in logic
                                _login();
                              } else {
                                // Sign up logic
                                _saveUser(usernameController.text,
                                    passwordController.text);

                                // Navigate to the Main Page
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainPage(
                                      username: usernameController.text,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text((onLogin)
                                ? 'ENTER THE STATION'
                                : 'JOIN THE STATION'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        onLogin = !onLogin;
                      });
                    },
                    style: TextButton.styleFrom(
                      primary: constants.kPrimaryColor,
                    ),
                    child: Text(
                      (onLogin)
                          ? "Haven't Joined the Station? Sign up"
                          : 'Already a Member? Enter',
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
