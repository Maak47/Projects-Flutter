import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:inner_voice/resources/auth_methods.dart';
import './create_profile.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  var _email = '';

  final _passwordController = TextEditingController();
  var _isLogin = true;
  var _passwordVisibility = true;

  void createProfile() async {
    await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const CreateProfileScreen()));
  }

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
    if (isValid) {
      _form.currentState!.save();

      if (_isLogin) {
        // final userCredentials =
        AuthMethods()
            .loginUser(email: _email, password: _passwordController.text);
        // print(userCredentials);
        if (_firebase.currentUser!.uid !=
            FirebaseFirestore.instance
                .collection('users')
                .doc(_firebase.currentUser!.uid)
                .id) {
          createProfile();
        }
      } else {
        // final userCredentials =
        AuthMethods()
            .signUpUser(email: _email, password: _passwordController.text);
        createProfile();
        // print(userCredentials);
      }
    }
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
                            textInputAction: !_isLogin
                                ? TextInputAction.next
                                : TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _passwordVisibility,
                            autocorrect: false,
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.trim().length < 6) {
                                return 'Please enter a password with length of atleast 6 characters';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _passwordController.text = value!;
                            }),
                        if (!_isLogin)
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
                                label: const Text('Confirm Password'),
                                hintText: 'Repeat Password',
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _passwordVisibility,
                              autocorrect: false,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    value != _passwordController.text) {
                                  return 'Password Invalid, Please type again.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _passwordController.text = value!;
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
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _submit();
                },
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
  return await _firebase.signInWithCredential(credential);
}
