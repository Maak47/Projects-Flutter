import 'package:flutter/material.dart';

import 'news_model.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsData newsData;

  const NewsDetailPage({required this.newsData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              newsData.title ?? '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (newsData.imageUrl != null)
              Image.network(
                newsData.imageUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),
            Text(
              'Published At: ${newsData.publishedAt ?? ''}',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              newsData.summary ?? '',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 75,
        width: 150,
        child: ElevatedButton.icon(
          onPressed: () {}, icon: Icon(Icons.search_off_rounded),
          label: Text('See more...'),
          //Text('See more'),
        ),
      ),
    );
  }
}
