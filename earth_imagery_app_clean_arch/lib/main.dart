import 'package:earth_imagery_app_clean_arch/features/auth/data/models/auth_model.dart';
import 'package:earth_imagery_app_clean_arch/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(AuthModelAdapter());

  await Hive.openBox<AuthModel>(
    'users',
  );
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
