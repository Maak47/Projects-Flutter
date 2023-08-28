import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inner_voice/tabs_screens/tabs.dart';

import '../widgets/user_image_picker.dart';

class CreateProfileScreen extends StatefulWidget {
  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bioController = TextEditingController();
  var _enteredBio;
  var _enteredUsername;
  var _enteredFullName;

  File? _profileImage;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    final userCredentials = FirebaseAuth.instance.currentUser!;
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_images/profile_images/${userCredentials.uid}.jpeg');

    await storageRef.putFile(_profileImage!);
    final profileImageUrl = await storageRef.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredentials.uid)
        .set({
      'full_name': _enteredFullName,
      'username': _enteredUsername,
      'email': userCredentials.email,
      'profile_image_url': profileImageUrl,
      'bio': _enteredBio,
    });

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const TabScreen()));
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Create Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  ProfileImagePicker(
                    onPickImage: (pickedImage) {
                      setState(() {
                        _profileImage = pickedImage;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter your Name'
                        : null,
                    onSaved: (value) => _enteredFullName = value!,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'Enter a username',
                      border: OutlineInputBorder(),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9a-z.]'))
                    ],
                    validator: (value) => value == null ||
                            RegExp(r"[/,[\]'\{}|:<>?!@#\$%^&*()_+=-]")
                                .hasMatch(value)
                        ? 'Only [.] dot Special character can be used'
                        : null,
                    onSaved: (value) => _enteredUsername = value!,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    maxLength: 150,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      labelText: 'Bio',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'Tell us about yourself',
                      border: OutlineInputBorder(),
                    ),
                    controller: _bioController,
                    onSaved: (value) => _enteredBio = value!,
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submit,
        child: Icon(Icons.arrow_forward_rounded),
      ),
    );
  }
}
