import 'package:earth_imagery_app/features/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'configs/constants/constants.dart';
import 'features/models/image_metadata.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ImageMetadataAdapter());
  await Hive.openBox<ImageMetadata>('imageMetadata');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: kTextTheme,
        colorScheme: ColorScheme.dark(
          brightness: Brightness.dark,
          primary: kPrimaryColor!,
          secondary: kAccentColor!,
          background: kBackgroundColor!,
        ),
      ),
      title: 'EarthVisor App',
      home: const AuthPage(),
    );
  }
}
