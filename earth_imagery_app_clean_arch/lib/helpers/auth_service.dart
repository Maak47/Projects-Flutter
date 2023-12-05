import 'package:appwrite/appwrite.dart';
import 'package:earth_imagery_app/features/pages/auth_page.dart';
import 'package:flutter/material.dart';

import '../features/pages/main_page.dart';

class AuthService {
  final Client client = Client()
    ..setEndpoint(
        'https://cloud.appwrite.io/v1') // Replace with your Appwrite endpoint
    ..setProject('imageryappearth') // Replace with your Appwrite project ID
    ..setSelfSigned();

  Future<void> login(BuildContext context, String email, String password,
      String username) async {
    try {
      // Create an email session for authentication
      await Account(client)
          .createEmailSession(email: email, password: password);
      final account = await Account(client).get();

      final username = account.name;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainPage(
                username: username,
              )));
    } catch (e) {
      // Handle login errors
      print('Login failed: $e');
      throw Exception('Login failed');
    }
  }

  Future<void> register(BuildContext context, String email, String username,
      String password) async {
    try {
      // Create a new account with email and password
      await Account(client).create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: username,
      );

      // Login the user after successful registration
      // ignore: use_build_context_synchronously
      await login(context, email, password, username);
    } catch (e) {
      // Handle registration errors
      print('Registration failed: $e');
      throw Exception('Registration failed');
    }
  }

  Future<void> logout(BuildContext context) async {
    await Account(client).deleteSession(sessionId: 'current');
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthPage()));
  }

  void _showSnackBar(BuildContext context, String message,
      Color backgroundColor, Color textColor) {
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
}
