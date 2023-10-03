import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/site.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Filter the recommended sites to only include favorites
    final favoriteSites =
        Site.recommendedSites.where((site) => site.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Sites'),
      ),
      body: ListView.builder(
        itemCount: favoriteSites.length,
        itemBuilder: (context, index) {
          final site = favoriteSites[index];
          return InkWell(
            onTap: () async {
              final url = Uri.parse(site.url);
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                // Handle error, e.g., display a snackbar
              }
            },
            child: Card(
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  Image.asset(site.imageUrl),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      site.name,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      site.url,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
