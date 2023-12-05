import 'package:earth_imagery_app/configs/constants/constants.dart';
import 'package:earth_imagery_app/features/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('users');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final constants = AppConstants();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: constants.kTextTheme,
        colorScheme: ColorScheme.dark(
          brightness: Brightness.dark,
          primary: constants.kPrimaryColor!,
          secondary: constants.kAccentColor!,
          background: constants.kBackgroundColor!,
        ),
      ),
      title: 'EarthVisor App',
      home: const AuthPage(),
    );
  }
}
