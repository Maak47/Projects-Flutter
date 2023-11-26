import 'package:flutter/material.dart';
import 'package:train_station_app/screens/create_packing_list.dart';
import 'package:train_station_app/screens/show_packing_list.dart';

import 'package:train_station_app/screens/stations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("STATION MASTER"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StationsScreen()));
                },
                child: buildCard(
                    "TRAIN STATIONS",
                    "This page will give you lists of codes for the local train stations and the station's names",
                    "assets/images/train.png")),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CreatePackingList()));
                },
                child: buildCard(
                    "ENTER PACKING LIST",
                    "You can type in the things you'll bring for your upcoming train travel journey",
                    "assets/images/book.png")),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ShowPackingList()));
              },
              child: buildCard(
                  "MY PACKING LIST",
                  "Don't forget to crosscheck your luggage and checklist the items that's ready for you to bring!",
                  "assets/images/checklist.png"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(String title, String description, String imageUrl) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              imageUrl,
              height: 150.0,
              fit: BoxFit.fitHeight,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
