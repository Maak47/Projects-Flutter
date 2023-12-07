// ignore_for_file: use_build_context_synchronously

import 'package:appwrite/appwrite.dart';
import 'package:earth_imagery_app/features/pages/auth_page.dart';
import 'package:flutter/material.dart';

import '../features/pages/main_page.dart';

const String endpoint = 'https://cloud.appwrite.io/v1';
const String projectId = 'imageryappearth';
const String databaseId = '65714307121f9035deec';
const String collectionId = '6571431479afa75c4852';
final database = Databases(client);

final Client client = Client()
  ..setEndpoint(endpoint) // Replace with your Appwrite endpoint
  ..setProject(projectId); // Replace with your Appwrite project ID
// ..setSelfSigned();

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
    (e.message);
  }
}

Future<void> register(BuildContext context, String email, String username,
    String password) async {
  try {
    await Account(client).create(
      userId: ID.unique(),
      email: email,
      password: password,
      name: username,
    );

    // Login the user after successful registration
    await login(context, email, password);
  } on AppwriteException catch (e) {
    //show message to user or do other operation based on error as required
    (e.message);
  }
}

Future<void> logout(BuildContext context) async {
  await Account(client).deleteSession(sessionId: 'current');
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AuthPage()));
}

Future<void> updateUserPreferences(
    bool isAerosolActive, bool isCloudsActive) async {
  final user = await Account(client).get();
  try {
    final database = Databases(client);

    final response = await database.updateDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: user.$id,
      data: {
        'isAerosolActive': isAerosolActive,
        'isCloudsActive': isCloudsActive,
        'isSubscribed': true,
      },
    );
    if (response.data.isNotEmpty) {
      final userPreferences = response.data;
      (userPreferences);
    }
  } on AppwriteException catch (e) {
    //show message to user or do other operation based on error as required
    (e.message);
  }
}

Future<Map<String, dynamic>?> fetchUserPreferences(String userId) async {
  final database = Databases(client);
  try {
    final response = await database.getDocument(
        databaseId: databaseId, collectionId: collectionId, documentId: userId);

    if (response.data.isNotEmpty) {
      final userPreferences = response.data;
      (userPreferences);
      return userPreferences;
    }
    return {
      'isSubscribed': false,
      'isAerosolActive': false,
      'isCloudsActive': false,
    };
  } on AppwriteException catch (e) {
    (e.message);
  }
  return null;
}

Future<void> createDocument(String userId) async {
  final database = Databases(client);
  final user = await Account(client).get();

  try {
    await database.createDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: userId,
      data: {
        'isSubscribed': false,
        'isAerosolActive': false,
        'isCloudsActive': false,
        'username': user.name,
        'email': user.email,
        'passwordHash': user.password,
        'creationDate': user.$createdAt,
      },
    );
  } on AppwriteException catch (e) {
    (e.message);
  }
}
