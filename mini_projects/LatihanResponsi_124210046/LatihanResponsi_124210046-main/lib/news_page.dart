// news_page.dart

import 'package:flutter/material.dart';
import 'package:latihan_responsi/api_data_source.dart';
import 'package:latihan_responsi/news_details_page.dart';
import 'package:latihan_responsi/news_model.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final ApiDataSource _apiDataSource = ApiDataSource.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("NEWS LIST"),
      ),
      body: _buildNewsPage(context),
    );
  }

  Widget _buildNewsPage(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _apiDataSource.loadData('/v4/articles/?format=json'),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            DataModel dataModel = DataModel.fromJson(snapshot.data);
            return _buildSuccessSection(
              context,
              dataModel,
            ); // Pass the context
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

// ... (rest of the code remains unchanged)
}

Widget _buildErrorSection() {
  return const Text('Error');
}

Widget _buildLoadingSection() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget _buildSuccessSection(BuildContext context, DataModel dataModel) {
  // Check if results or events is null
  if (dataModel.results == null) {
    return const Text('No data available');
  }

  return ListView.builder(
    itemCount: dataModel.results!.length,
    itemBuilder: (BuildContext context, int index) {
      return _BuildItemUsers(
        context,
        dataModel.results![index],
      );
    },
  );
}

Widget _BuildItemUsers(BuildContext context, NewsData data) {
  // Add the context parameter
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailPage(newsData: data),
          ));
    },
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 125,
              width: 200,
              child: Image.network(
                data?.imageUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
                width: 150,
                child: Text(
                  data?.title as String,
                  style: const TextStyle(fontSize: 18),
                )),
          ],
        ),
      ),
    ),
  );
}
