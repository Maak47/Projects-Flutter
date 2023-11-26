import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../models/station.dart';

class APIService {
  final String apiUrl = 'https://booking.kai.id/api/stations2';

  Future<List<Station>> fetchStations() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      List<Station> stations =
          jsonResponse.map((station) => Station.fromJson(station)).toList();

      saveStationsToLocalDatabase(stations);
      return stations;
    } else {
      throw Exception('Failed to load station');
    }
  }

  void saveStationsToLocalDatabase(List<Station> stations) async {
    var box = await Hive.openBox<Station>('stations');
    box.addAll(stations);
  }
}
