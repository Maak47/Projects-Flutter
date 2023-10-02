import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inner_voice/responsive/mobile_layout.dart';
import 'package:inner_voice/responsive/responsive_layout.dart';
import 'package:inner_voice/responsive/web_layout.dart';
import './screens/auth.dart';
import './utilities/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCAEDJ6ZlCGY01-ZlwqhVC5oafTz-GmrvE',
      appId: "1:100481014343:web:1c517666203a99bd71ef62",
      messagingSenderId: "100481014343",
      projectId: "innervoice11",
      storageBucket: "innervoice11.appspot.com",
    ),
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
        textTheme: const TextTheme(
            titleMedium: TextStyle(fontWeight: FontWeight.bold)),
        fontFamily: 'CC-Single-Bound',
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          background: kBackgroundColor,
          brightness: Brightness.dark,
          primary: kPrimaryColor,
          secondary: kSecondaryColor,
          tertiary: kTertiaryColor,
        ),
      ),
      // home: NewUserFormScreen(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return const ResponsiveLayout(
              mobileLayout: MobileLayout(),
              webLayout: WebLayout(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return const AuthScreen();
        },
      ),
    );
  }
}
