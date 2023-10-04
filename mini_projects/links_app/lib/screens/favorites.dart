import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

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
          final url = Uri.parse(site.url);
          return Link(
            uri: url,
            builder: (context, openLink) => InkWell(
              onTap: openLink,
              child: Card(
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Image.network(site.imageUrl),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
