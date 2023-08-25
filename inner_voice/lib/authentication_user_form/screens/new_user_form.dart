import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/user_image_picker.dart';

class NewUserFormScreen extends StatefulWidget {
  const NewUserFormScreen({super.key});

  @override
  State<NewUserFormScreen> createState() => _NewUserFormScreenState();
}

class _NewUserFormScreenState extends State<NewUserFormScreen> {
  final form = GlobalKey<FormState>();
  var _enteredFullName = '';
  var _enteredUsername = '';
  var _enteredBio = '';
  final bioController = TextEditingController();

  File? profileImage;

  void _submit() async {
    final isValid = form.currentState!.validate();
    if (!isValid || profileImage == null) {
      return;
    }
    if (isValid) {
      form.currentState!.save();
      final userCredentials = FirebaseAuth.instance.currentUser;

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images/profile_images')
          .child('${userCredentials!.uid}.jpeg');
      await storageRef.putFile(profileImage!);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
        ),
        title: const Text('Create Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: form,
                child: Column(
                  children: <Widget>[
                    ProfileImagePicker(
                      onPickImage: (pickedImage) {
                        profileImage = pickedImage;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          label: Text('Name'),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Enter your name',
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredFullName = value!;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          label: Text('Username'),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Enter a username',
                          border: OutlineInputBorder()),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9a-z.]'))
                      ],
                      validator: (value) {
                        if (value == null ||
                            value.contains(
                              RegExp("[A-Z]"),
                            )) {
                          return 'Only [.] Special characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredUsername = value!;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLength: 150,
                      maxLines: 3,
                      // maxLengthEnforcement:
                      //     MaxLengthEnforcement.truncateAfterCompositionEnds,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      decoration: const InputDecoration(
                          label: Text('Bio'),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Tell us about yourself',
                          border: OutlineInputBorder()),
                      controller: bioController,
                      onSaved: (value) {
                        _enteredBio = value!;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 5),
                      // backgroundColor: Colors.amber[600],
                      // foregroundColor: Colors.white),
                      onPressed: _submit,
                      child: const Text('Create My Profile'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
