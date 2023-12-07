import 'package:appwrite/appwrite.dart';
import 'package:earth_imagery_app/features/pages/auth_page.dart';
import 'package:flutter/material.dart';

import '../features/pages/main_page.dart';

final String endpoint = 'https://cloud.appwrite.io/v1';
final String projectId = 'imageryappearth';
final String databaseId = '65714307121f9035deec';
final String collectionId = '6571431479afa75c4852';
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
    print(e.message);
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
      },
    );
    if (response.data != null) {
      final userPreferences = response.data;
      print(userPreferences);
    }
  } on AppwriteException catch (e) {
    //show message to user or do other operation based on error as required
    print(e.message);
  }
}

Future<Map<String, dynamic>?> fetchUserPreferences(String userId) async {
  final database = Databases(client);
  final user = await Account(client).get();
  try {
    final response = await database.getDocument(
        databaseId: databaseId, collectionId: collectionId, documentId: userId);

    if (response.data != null) {
      final userPreferences = response.data;
      print(userPreferences);
      return userPreferences;
    } else {
      await database.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: user.$id,
        data: {
          'isAerosolActive': false,
          'isCloudsActive': false,
          'username': user.name,
          'email': user.email,
          'passwordHash': user.password,
          'creationDate': user.$createdAt,
        },
      );
      return {
        'isAerosolActive': false,
        'isCloudsActive': false,
      };
    }
  } on AppwriteException catch (e) {
    print(e.message);
  }
  return null;
}
