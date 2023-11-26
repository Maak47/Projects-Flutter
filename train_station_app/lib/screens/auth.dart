import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_station_app/widgets/bottom_nav.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true; // Initially, show the login UI

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Login' : 'Sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16.0),
            if (!isLogin) // Show this only in the signup state
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Confirm Password'),
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text;
                String password = _passwordController.text;

                if (isLogin) {
                  // Handle login
                  bool success = await loginUser(username, password);
                  if (success) {
                    // Navigate to the home screen or perform other actions
                    print('Login successful!');
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => BottomNav()));
                  } else {
                    // Handle login failure
                    print('Login failed. Invalid credentials.');
                  }
                } else {
                  // Handle signup
                  String confirmPassword = _confirmPasswordController.text;
                  if (password == confirmPassword) {
                    bool success = await signupUser(username, password);
                    if (success) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => BottomNav()));
                    } else {
                      // Handle signup failure
                      print('Signup failed. User already exists.');
                    }
                  } else {
                    // Passwords don't match
                    print('Passwords do not match');
                  }
                }
              },
              child: Text(isLogin ? 'Login' : 'Sign up'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(
                  isLogin ? 'Not a user? Sign up' : 'Already a user? Login'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> loginUser(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedPassword = prefs.getString(username);

    if (savedPassword != null && savedPassword == password) {
      return true; // Login successful
    } else {
      return false; // Invalid credentials
    }
  }

  Future<bool> signupUser(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedPassword = prefs.getString(username);

    if (savedPassword == null) {
      // User doesn't exist, save the password
      prefs.setString(username, password);
      return true; // Signup successful
    } else {
      return false; // User already exists
    }
  }
}
