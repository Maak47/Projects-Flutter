import 'package:flutter/material.dart';
import 'package:latihan_responsi/reportsmodel.dart';

class ReportsDetailPage extends StatelessWidget {
  final ReportsModel reportData;

  const ReportsDetailPage({required this.reportData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reportData.title ?? '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (reportData.imageUrl != null)
              Image.network(
                reportData.imageUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),
            Text(
              'Published At: ${reportData.publishedAt ?? ''}',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              reportData.summary ?? '',
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
