import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'create_profile.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  var _isLogin = true;
  var _passwordVisibility = true;
  var _password;
  var _email;
  String? _errorMessage;

  void _navigateToCreateProfilePage() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => CreateProfileScreen()));
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    try {
      if (_isLogin) {
        final currentUserDoc = FirebaseFirestore.instance
            .collection('users')
            .doc(_firebase.currentUser!.uid);
        final currentUserDocSnapshot = await currentUserDoc.get();

        if (!currentUserDocSnapshot.exists) {
          _navigateToCreateProfilePage();
          return;
        }

        await _firebase.signInWithEmailAndPassword(
            email: _email, password: _password);
      } else {
        await _firebase.createUserWithEmailAndPassword(
            email: _email, password: _password);
        _navigateToCreateProfilePage();
      }
    } on FirebaseAuthException catch (error) {
      _errorMessage = error.message;
      _viewSnackBar();
    }
  }

  void _viewSnackBar() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(_errorMessage ?? 'Authentication Failed'),
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
                    key: _formKey,
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
                              _password = value!;
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
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  return await _firebase.signInWithCredential(credential);
}
