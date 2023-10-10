import 'package:bloc_phone_authentication/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_phone_authentication/firebase_options.dart';
import 'package:bloc_phone_authentication/screen/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCvuQTtLqX3mZKZ2t2OPP--qYc7fnTMzG4",
          authDomain: "bloc-implementation0.firebaseapp.com",
          projectId: "bloc-implementation0",
          storageBucket: "bloc-implementation0.appspot.com",
          messagingSenderId: "1029139894402",
          appId: "1:1029139894402:web:310449dca6bc5c6e1b649b",
          measurementId: "G-DTK9XVCQQF"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
          useMaterial3: true,
        ),
        home: SignInScreen(),
      ),
    );
  }
}
