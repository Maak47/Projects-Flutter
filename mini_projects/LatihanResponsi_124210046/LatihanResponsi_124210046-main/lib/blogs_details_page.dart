import 'package:flutter/material.dart';
import 'package:latihan_responsi/blog_model.dart';

class BlogsDetailPage extends StatelessWidget {
  final BlogModel blogData;

  const BlogsDetailPage({required this.blogData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              blogData.title ?? '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (blogData.imageUrl != null)
              Image.network(
                blogData.imageUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),
            Text(
              'Published At: ${blogData.publishedAt ?? ''}',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              blogData.summary ?? '',
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
