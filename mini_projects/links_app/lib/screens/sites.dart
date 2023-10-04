import 'package:flutter/material.dart';
import 'package:links_app/screens/favorites.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/site.dart';

class SitesScreen extends StatefulWidget {
  @override
  _SitesScreenState createState() => _SitesScreenState();
}

class _SitesScreenState extends State<SitesScreen> {
  // Define a list of recommended sites here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Sites'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0.1, // Adjust the number of columns as needed
        ),
        itemCount: Site.recommendedSites.length,
        itemBuilder: (context, index) {
          final site = Site.recommendedSites[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SiteItem(
              site: site,
              onFavoriteTap: () {
                setState(() {
                  site.isFavorite = !site.isFavorite;
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FavoritesScreen()));
          },
          child: Icon(Icons.favorite)),
    );
  }
}

class SiteItem extends StatelessWidget {
  final Site site;
  final VoidCallback onFavoriteTap;

  SiteItem({
    required this.site,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final websiteUri = Uri.parse(site.url);
    return Link(
      uri: websiteUri,
      builder: (context, openLink) => InkWell(
        onTap: openLink,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 8),
                  height: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            site.imageUrl,
                          ),
                          fit: BoxFit.fill)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(site.name),
                    IconButton(
                      icon: Icon(
                        site.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: onFavoriteTap,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
