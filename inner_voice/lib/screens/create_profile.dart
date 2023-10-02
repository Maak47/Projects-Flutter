import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inner_voice/resources/auth_methods.dart';
import 'package:inner_voice/responsive/mobile_layout.dart';

import 'auth.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final form = GlobalKey<FormState>();
  var _enteredFullName = '';
  var _enteredUsername = '';
  var _enteredBio = '';

  late Uint8List profileImage;

  @override
  void initState() {
    super.initState();
    profileImage = Uint8List(0);
  }

  void _submit() async {
    final isValid = form.currentState!.validate();
    if (!isValid) {
      return;
    }

    if (isValid) {
      form.currentState!.save();
      AuthMethods().createProfile(
          username: _enteredUsername,
          fullName: _enteredFullName,
          bio: _enteredBio,
          file: profileImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => const AuthScreen()));
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
                    CircleAvatar(
                      backgroundImage: MemoryImage(profileImage),
                    ),
                    // const ImageSelector(),
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
                      onPressed: () {
                        _submit();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) => const MobileLayout()));
                      },
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
