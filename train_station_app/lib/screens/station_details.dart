// station_detail.dart

import 'package:flutter/material.dart';
import '../models/station.dart';

class StationDetailPage extends StatelessWidget {
  final Station station;

  const StationDetailPage({Key? key, required this.station}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Station Detail'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Image.asset(
                'assets/images/kai.png',
                height: 80,
              ),
              SizedBox(height: 25),
              Text(
                'Kode Stasiun: ${station.code}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'STASIUN ${station.name}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'KOTA ${station.city}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '${station.cityname}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
