import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../../authentication_user_form/widgets/user_image_picker.dart';
import '../widgets/profile_card.dart';

final db = FirebaseFirestore.instance;
final userCreds = FirebaseAuth.instance.currentUser!;

class UserSelfProfileScreen extends StatefulWidget {
  const UserSelfProfileScreen({super.key});

  @override
  State<UserSelfProfileScreen> createState() => _UserSelfProfileScreenState();
}

class _UserSelfProfileScreenState extends State<UserSelfProfileScreen> {
  final form = GlobalKey<FormState>();

  var editedName = '';
  var editedBio = '';
  var editedUsername = '';

  // var bioController = TextEditingController();

  File? profileImage;

  void submit() async {
    final isValid = form.currentState!.validate();

    if (!isValid) {
      return;
    }

    if (isValid) {
      form.currentState!.save();

      Map<String, dynamic> updatedFields = {};

      if (profileImage != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images/profile_images/${userCreds.uid}.jpeg');

        await storageRef.putFile(profileImage!);
        final profileImageUrl = await storageRef.getDownloadURL();

        await userCreds.updatePhotoURL(profileImageUrl);

        updatedFields['profile_image_url'] = profileImageUrl;
      }

      if (editedUsername.isNotEmpty) {
        updatedFields['username'] = editedUsername;
      }

      if (editedName.isNotEmpty) {
        updatedFields['full_name'] = editedName;
      }

      if (editedBio.isNotEmpty) {
        updatedFields['bio'] = editedBio;
      }

      if (updatedFields.isNotEmpty) {
        await db.collection('users').doc(userCreds.uid).update(updatedFields);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Your Profile'),
          actions: const [],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                      'Something went wrong.. ${snapshot.error.toString()}'),
                );
              }
              final data = snapshot.data!.data()!;
              return Center(
                child: Stack(children: [
                  ProfileCard(
                    fullName: data['full_name'],
                    username: data['username'],
                    imageUrl: data['profile_image_url'],
                    bio: data['bio'],
                  ),
                  Positioned(
                    right: 120,
                    top: 0,
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => editDialog());
                      },
                      color: Theme.of(context).colorScheme.tertiary,
                      icon: const Icon(
                        Icons.edit_square,
                      ),
                    ),
                  ),
                ]),
              );
            }));
  }

  Widget editDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Edit',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
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
                    if (value == null) {
                      return 'Please enter your Name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    editedName = value!;
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
                          RegExp("[/,[]\\'\"{}|:<>?!@#\$%^&*()_+=-]"),
                        )) {
                      return 'Only [.] dot Special character can be used';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    editedUsername = value!;
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
                  // controller: bioController,
                  onSaved: (value) {
                    editedBio = value!;
                  },
                ),
                SizedBox(
                  width: 320.0,
                  child: ElevatedButton(
                    onPressed: () {
                      submit();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Save",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget formFields(
  //   String enterLabel,
  //   String enterHinttext,
  //   int? enterMaxLenth,
  //   int? enterMaxLines,
  //   String? Function(String?)? validator,
  //   void Function(String?)? onSaved,
  // ) {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //         border: InputBorder.none,
  //         label: Text(enterLabel),
  //         hintText: enterHinttext),
  //     maxLength: enterMaxLenth,
  //     maxLines: enterMaxLines,
  //     validator: validator,
  //     onSaved: onSaved,
  //   );
  // }
}
