import 'package:earth_imagery_app_clean_arch/configs/constants/constants.dart';
import 'package:earth_imagery_app_clean_arch/features/auth/data/models/auth_model.dart';
import 'package:earth_imagery_app_clean_arch/features/auth/presentation/pages/auth_page.dart';
import 'package:earth_imagery_app_clean_arch/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/auth/models/user_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('users');
  runApp(MyApp());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final constants = AppConstants();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: AuthPage(),
    );
  }
}
