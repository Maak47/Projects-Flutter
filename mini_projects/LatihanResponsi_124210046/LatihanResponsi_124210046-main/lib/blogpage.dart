import 'package:flutter/material.dart';
import 'package:latihan_responsi/api_data_source.dart';
import 'package:latihan_responsi/blog_model.dart';
import 'package:latihan_responsi/blogs_details_page.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("BLOGS LIST"),
      ),
      body: _buildBlogPage(context),
    );
  }

  Widget _buildBlogPage(BuildContext context) {
    return Container(
      child: FutureBuilder<List<BlogModel>>(
        future: ApiDataSource.instance.loadBlogs('/v4/blogs/?format=json'),
        builder:
            (BuildContext context, AsyncSnapshot<List<BlogModel>> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            List<BlogModel> blogData = snapshot.data!;
            return _buildSuccessSection(context, blogData);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return const Text('Error');
  }

  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(BuildContext context, List<BlogModel> data) {
    if (data.isEmpty) {
      return const Text('No data available');
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return _BuildItemBlog(context, data[index]);
      },
    );
  }

  Widget _BuildItemBlog(BuildContext context, BlogModel data) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogsDetailPage(blogData: data),
            ));
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 150,
              child: Image.network(
                data.imageUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(width: 175, child: Text(data.title ?? '')),
          ],
        ),
      ),
    );
  }
}
