import 'package:flutter/material.dart';
import 'package:latihan_responsi/reports_details_page.dart';

import 'api_data_source.dart'; // Import your ApiDataSource
import 'reportsmodel.dart'; // Import your ReportsModel

class ReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports List'),
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.loadData(
            '/v4/reports/?from=json'), // Replace with your actual endpoint
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Assuming your response contains a list of ReportsModel
            final List<ReportsModel> reports =
                (snapshot.data['results'] as List)
                    .map((e) => ReportsModel.fromJson(e))
                    .toList();

            return ReportsListPage(reports: reports);
          }
        },
      ),
    );
  }
}

class ReportsListPage extends StatelessWidget {
  final List<ReportsModel> reports;

  ReportsListPage({required this.reports});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (context, index) {
        return _buildReportItem(context, reports[index]);
      },
    );
  }

  Widget _buildReportItem(BuildContext context, ReportsModel report) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReportsDetailPage(reportData: report),
            ));
      },
      child: Card(
        child: ListTile(
          leading: Image.network(
            report.imageUrl!,
            width: 175.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          title: Text(report.title!),
          subtitle: Text(
            'Published at: ${_formatDate(report.publishedAt!)}',
          ),
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    // Assuming dateString is in the format "2023-11-16T20:09:00Z"
    DateTime dateTime = DateTime.parse(dateString);
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
