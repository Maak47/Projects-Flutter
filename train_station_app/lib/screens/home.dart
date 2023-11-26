import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../helpers/handlers.dart';
import '../models/station.dart';

class HomeScreen extends StatelessWidget {
  final APIService apiService = APIService();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STATIONS'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Station>>(
        future: apiService.fetchStations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error : ${snapshot.error}'),
            );
          } else {
            List<Station> stations = snapshot.data!;
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: stations.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  child: ListTile(
                    title: Text(stations[index].name ?? ''),
                    subtitle: Text(stations[index].cityname ?? ''),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Station>> fetchStations() async {
    var box = await Hive.openBox<Station>('stations');
    if (box.isNotEmpty) {
      return box.values.toList();
    } else {
      return apiService.fetchStations();
    }
  }
}
