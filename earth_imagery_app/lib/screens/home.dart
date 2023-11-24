import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map<String, dynamic>> earthImages;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch earth images from NASA EPIC API
    fetchEarthImages();
  }

  Future<void> fetchEarthImages() async {
    final response = await http.get(
      Uri.parse('https://api.nasa.gov/EPIC/api/natural/all?api_key=DEMO_KEY'),
    );

    if (response.statusCode == 200) {
      // Parse the JSON response and extract relevant information
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        earthImages = data
            .map<Map<String, dynamic>>((dynamic item) =>
                {'image': item['image'], 'title': item['caption']})
            .toList();
      });
    } else {
      // Handle error
      print('Failed to fetch earth images: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NASA Earth Images'),
      ),
      body: earthImages == null
          ? Center(child: CircularProgressIndicator())
          : buildEarthImageCarousel(),
    );
  }

  Widget buildEarthImageCarousel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // Open detailed page when tapping on the current image
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  image: earthImages[currentIndex]['image'],
                  title: earthImages[currentIndex]['title'],
                ),
              ),
            );
          },
          child: Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              earthImages[currentIndex]['image'],
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          earthImages[currentIndex]['title'],
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 20),
        buildImageCarouselIndicator(),
      ],
    );
  }

  Widget buildImageCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < earthImages.length; i++)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == i ? Colors.blue : Colors.grey,
            ),
          ),
      ],
    );
  }
}

class DetailPage extends StatelessWidget {
  final String image;
  final String title;

  const DetailPage({Key? key, required this.image, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            image,
            fit: BoxFit.cover,
            height: 300,
            width: double.infinity,
          ),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
