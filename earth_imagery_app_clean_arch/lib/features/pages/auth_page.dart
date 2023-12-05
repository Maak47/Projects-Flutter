import 'dart:convert';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:earth_imagery_app/configs/constants/constants.dart';
import 'package:earth_imagery_app/helpers/auth_service.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final constants = AppConstants();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.asset(
                'assets/images/auth_image.jpg', // Replace with your image URL
                fit: BoxFit.cover,
              ),
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
                        'IMAGERY',
                        style: TextStyle(
                            color: constants.kTextColor, fontSize: 75),
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
                    SizedBox(
                      width: 235,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Stack(
                                  children: [
                                    Container(
                                      color: Colors.black.withOpacity(0.5),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 5, sigmaY: 5),
                                        child: Container(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                    AuthCard(onLogin: true),
                                  ],
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: constants.kTextColor,
                          backgroundColor: constants.kPrimaryColor,
                          padding: const EdgeInsets.all(16.0),
                        ),
                        child: const Text('Login'),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 235,
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Stack(
                                  children: [
                                    Container(
                                      color: Colors.black.withOpacity(0.5),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 5, sigmaY: 5),
                                        child: Container(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                    AuthCard(onLogin: false),
                                  ],
                                );
                              });
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xff2EC4B6)),
                              borderRadius: BorderRadius.circular(25)),
                          foregroundColor: constants.kPrimaryColor,
                          backgroundColor: Colors.transparent,
                          padding: const EdgeInsets.all(16.0),
                        ),
                        child: const Text('Create an Account'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AuthCard extends StatefulWidget {
  bool onLogin;
  AuthCard({super.key, required this.onLogin});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final constants = AppConstants();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Enter Your Credentials.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.cancel_outlined))
                  ],
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
                        controller: emailController,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            filled: true, // Set to true to fill the background
                            fillColor: const Color(0xff2EC4B6),
                            alignLabelWithHint: true, // Center-align the label

                            labelText: 'email',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
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
                      if (!widget.onLogin) const SizedBox(height: 16.0),
                      if (!widget.onLogin)
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
                            filled: true, // Set to true to fill the background
                            fillColor: const Color(0xff2EC4B6),
                            alignLabelWithHint: true, // Center-align the label

                            labelText: 'Password',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
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
                              side: const BorderSide(color: Color(0xff2EC4B6))),
                          backgroundColor: Colors.transparent,
                          foregroundColor: constants.kPrimaryColor,
                          padding: const EdgeInsets.all(16.0),
                        ),
                        onPressed: () {
                          if (!widget.onLogin) {
                            // Log in logic
                            AuthService().register(
                                context,
                                emailController.text,
                                usernameController.text,
                                _hashPassword(passwordController.text));
                          } else {
                            // Sign up logic
                            AuthService().login(
                                context,
                                emailController.text,
                                _hashPassword(passwordController.text),
                                usernameController.text);
                            // Navigate to the Main Page
                          }
                        },
                        child: Text((widget.onLogin)
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
                    widget.onLogin = !widget.onLogin;
                  });
                },
                style: TextButton.styleFrom(
                  foregroundColor: constants.kPrimaryColor,
                ),
                child: Text(
                  (widget.onLogin)
                      ? "Haven't Joined the Station? Sign up"
                      : 'Already a Member? Enter',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
