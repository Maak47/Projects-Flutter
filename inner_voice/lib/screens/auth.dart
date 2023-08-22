import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var _isLogin = true;
  var _passwordVisibility = true;
  String? _errorMessage = '';

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
    if (isValid) {
      _form.currentState!.save();
      try {
        if (_isLogin) {
          final userCredentials = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password);
          print(userCredentials);
        } else {
          final userCredentials = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email, password: _password);
          print(userCredentials);
        }
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          //..
        }
        _errorMessage = _errorMessage;
        showSnackBar();
      }
    }
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(_errorMessage ?? 'Authenticaton Failed'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                width: 300,
                child: Image.asset('assets/images/innervoice_logo.jpg'),
              ),
              const SizedBox(
                height: 100,
              ),
              Card(
                margin: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                            decoration: const InputDecoration(
                              label: Text('Email'),
                              hintText: 'Enter Email',
                              border: InputBorder.none,
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            autocorrect: false,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please Enter a Valid Email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _email = value!;
                            }),
                        TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisibility =
                                          !_passwordVisibility;
                                    });
                                  },
                                  icon: Icon((_passwordVisibility)
                                      ? Icons.visibility_off
                                      : Icons.visibility)),
                              label: const Text('Password'),
                              hintText: 'Enter Password',
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            obscureText: _passwordVisibility,
                            autocorrect: false,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.trim().length < 6) {
                                return 'Please enter a password with length of atleast 6 characters';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value!;
                            }),
                      ],
                    ),
                  ),
                )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text((_isLogin) ? 'Or Login with' : 'Or Sign Up with'),
                  const SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                    onTap: signInWithGoogle,
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset(
                        'assets/images/google_logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                    onTap: signInWithFacebook,
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset(
                        'assets/images/facebook_logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  (_isLogin) ? 'Log In' : 'Sign Up',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
                child: Text((_isLogin)
                    ? 'Don\'t have an account? Create here.'
                    : 'Already have an account? Login here.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);

  // Once signed in, return the UserCredential
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}

