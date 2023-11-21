import 'package:flutter/material.dart';
import 'package:latihan_responsi/blogpage.dart';
import 'package:latihan_responsi/news_page.dart';
import 'package:latihan_responsi/reportspage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Space Flight News"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => NewsPage()));
                },
                child: buildCard(
                    "NEWS",
                    "Get an overview of the latest Spaceflight news, from various sources! Easily link your users to the right websites",
                    "assets/News.png")),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BlogPage()));
                },
                child: buildCard(
                    "BLOG",
                    "Blogs often provide a more detailed overview of launches and missions. A must-have for the serious spaceflight enthusiast",
                    "assets/Blogs.png")),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ReportsPage()));
              },
              child: buildCard(
                  "REPORTS",
                  "Space station and other missions often publish their data. with SNAPI, you can include it in your app as well!",
                  "assets/Reports.png"),
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
