import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scribbles/widgets/user_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';
  var _isAuthenticating = false;

  File? _selectedImage;

  void _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid || !_isLogin && _selectedImage == null) {
      return;
    }

    if (isValid) {
      _form.currentState!.save();
      try {
        setState(() {
          _isAuthenticating = true;
        });
        if (_isLogin) {
          // ignore: unused_local_variable
          final userCredentials = await _firebase.signInWithEmailAndPassword(
              email: _enteredEmail, password: _enteredPassword);
        } else {
          final userCredentials =
              await _firebase.createUserWithEmailAndPassword(
                  email: _enteredEmail, password: _enteredPassword);
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('user_images')
              .child('${userCredentials.user!.uid}.jpeg');
          await storageRef.putFile(_selectedImage!);
          final imageUrl = await storageRef.getDownloadURL();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredentials.user!.uid)
              .set({
            'username': _enteredUsername,
            'email': _enteredEmail,
            'image_url': imageUrl,
          });
        }
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          //..
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Center(child: Text(error.message ?? 'Authentication Failed!')),
          ),
        );
        setState(() {
          _isAuthenticating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                top: 30,
                right: 20,
                bottom: 20,
              ),
              width: 200,
              child: Image.asset('assets/images/chat.png'),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _form,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!_isLogin)
                          UserImagePicker(
                            onPickImage: (pickedImage) {
                              _selectedImage = pickedImage;
                            },
                          ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Email Address'),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredEmail = value!;
                          },
                        ),
                        if (!_isLogin)
                          TextFormField(
                            enableSuggestions: false,
                            decoration:
                                const InputDecoration(labelText: 'Username'),
                            validator: (value) {
                              if (value == null || value.trim().length < 4) {
                                return 'Username must be 4 characters long';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredUsername = value!;
                            },
                          ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'Password must be atleast 6 characters long.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredPassword = value!;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        if (_isAuthenticating)
                          const CircularProgressIndicator(),
                        if (!_isAuthenticating)
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                            child: Text(_isLogin ? 'Login' : 'Sign Up'),
                          ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(_isLogin
                              ? 'Create an Account'
                              : 'I already have an account. Login.'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
