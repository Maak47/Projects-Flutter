import 'package:flutter/material.dart';
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
          crossAxisCount: 2, // Adjust the number of columns as needed
        ),
        itemCount: Site.recommendedSites.length,
        itemBuilder: (context, index) {
          final site = Site.recommendedSites[index];
          return SiteItem(
            site: site,
            onFavoriteTap: () {
              setState(() {
                site.isFavorite = !site.isFavorite;
              });
            },
          );
        },
      ),
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
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Image.network(
            site.imageUrl,
            width: 150,
            height: 50,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(site.name),
                IconButton(
                  icon: Icon(
                    site.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: onFavoriteTap,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              final url = Uri.parse(site.url);

              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Something Went Wrong.. Try again'),
                  ),
                );
              }
            },
            child: Text(
              site.url,
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
