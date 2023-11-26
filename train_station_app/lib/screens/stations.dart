import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_station_app/screens/auth.dart';
import 'package:train_station_app/screens/station_details.dart';
import '../helpers/handlers.dart';
import '../models/station.dart';

class StationsScreen extends StatelessWidget {
  StationsScreen({super.key});

  final APIService apiService = APIService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TRAIN STATIONS',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchStations();
        },
        child: FutureBuilder<List<Station>>(
          future: apiService.fetchStations(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: SizedBox(child: Text('Error : ${snapshot.error}')),
              );
            } else {
              List<Station> stations = snapshot.data!;
              return ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: stations.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      _navigateToDetailPage(context, stations[index]);
                    },
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/kai.png',
                          width: 100,
                          height: 75,
                        ),
                        title: Text(stations[index].code ?? ''),
                        subtitle: Text(stations[index].name ?? ''),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
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

  void _navigateToDetailPage(BuildContext context, Station station) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StationDetailPage(station: station),
      ),
    );
  }

  void _logout(BuildContext context) async {
    // Logout logic
    await clearLoginState();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthScreen()),
    );
  }

  Future<void> clearLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLoggedIn');
  }
}
