import 'package:bloc_phone_authentication/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_phone_authentication/cubits/auth_cubit/auth_state.dart';
import 'package:bloc_phone_authentication/firebase_options.dart';
import 'package:bloc_phone_authentication/screen/home.dart';
import 'package:bloc_phone_authentication/screen/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
          appBarTheme: const AppBarTheme(backgroundColor: Colors.cyan),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) {
            return previous is AuthInitial;
          },
          builder: (context, state) {
            if(state is AuthLoggedInState){
              return HomeScreen();

            } else if(state is AuthLoggedOutState){
              return SignInScreen();
            }else {
              return Scaffold();
            }},
        ),
      ),
    );
  }
}
