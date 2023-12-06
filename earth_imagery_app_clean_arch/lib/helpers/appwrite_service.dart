import 'package:appwrite/appwrite.dart';
import 'package:earth_imagery_app/features/pages/auth_page.dart';
import 'package:flutter/material.dart';

import '../features/pages/main_page.dart';

final Client client = Client()
  ..setEndpoint(
      'https://cloud.appwrite.io/v1') // Replace with your Appwrite endpoint
  ..setProject('imageryappearth') // Replace with your Appwrite project ID
  ..setSelfSigned();

Future<void> login(
  BuildContext context,
  String email,
  String password,
) async {
  try {
    // Create an email session for authentication
    await Account(client).createEmailSession(email: email, password: password);
    final account = await Account(client).get();

    final username = account.name;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MainPage(
              username: username,
            )));
  } on AppwriteException catch (e) {
    //show message to user or do other operation based on error as required
    print(e.message);
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
    await login(context, email, password);
  } on AppwriteException catch (e) {
    //show message to user or do other operation based on error as required
    print(e.message);
  }
}

Future<void> logout(BuildContext context) async {
  await Account(client).deleteSession(sessionId: 'current');
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AuthPage()));
}

void _showSnackBar(BuildContext context, String message, Color backgroundColor,
    Color textColor) {
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

Future<void> updateUserPreferences(
    String userId, bool isAerosolTabLocked, bool isCloudsTabLocked) async {
  try {
    final database = Databases(client);

    await database.updateDocument(
      databaseId: '656f76625194974b53ae',
      collectionId: '656f766aee52043c4ce9',
      documentId: userId,
      data: {
        'isAerosolLocked': isAerosolTabLocked,
        'isCloudsTabLocked': isCloudsTabLocked,
      },
    );
  } on AppwriteException catch (e) {
    //show message to user or do other operation based on error as required
    print(e.message);
  }
}

Future<Map<String, dynamic>?> fetchUserPreferences(String userId) async {
  final database = Databases(client);
  try {
    final response = await database.getDocument(
        databaseId: '656f76625194974b53ae',
        collectionId: '656f766aee52043c4ce9',
        documentId: userId);

    if (response.data != null) {
      final userPreferences = response.data;
      return userPreferences;
    } else {
      await database.createDocument(
        databaseId: '656f76625194974b53ae',
        collectionId: '656f766aee52043c4ce9',
        documentId: userId,
        data: {
          'isAerosolLocked': false,
          'isCloudsTabLocked': false,
        },
      );
      return {
        'isAerosolTabLocked': false,
        'isCloudsTabLocked': false,
      };
    }
  } on AppwriteException catch (e) {
    print(e.message);
  }
  return null;
}
