import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './screens/auth.dart';
import './screens/tabs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InnerVoice',
      theme: ThemeData(
        fontFamily: 'CC-Single-Bound',
        colorScheme: const ColorScheme.dark(
            background: Colors.black,
            brightness: Brightness.dark,
            primary: Colors.amber,
            secondary: Colors.white,
            tertiary: Colors.grey),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return const TabScreen();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}
