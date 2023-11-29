import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travel_app_ca_riverpod_hive/features/trip/data/models/trip_model.dart';
import 'package:travel_app_ca_riverpod_hive/features/trip/domain/entities/trip_entity.dart';
import 'package:travel_app_ca_riverpod_hive/features/trip/presentation/screens/main_screen.dart';

Future<void> main() async {
  // Ensure the Flutter widgets binding is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and open your box.
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(TripModelAdapter());
  await Hive.openBox<TripModel>('trips');

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
