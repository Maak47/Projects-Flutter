import 'package:earth_imagery_app/screens/imagedetail.dart';
import 'package:earth_imagery_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>>? earthImages;
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    // Fetch earth images from NASA EPIC API
    fetchEarthImages();

    // Initialize PageController
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.85, // Set a custom viewportFraction
    );
  }

  Future<void> fetchEarthImages() async {
    final response = await http.get(
      Uri.parse(
          'https://api.nasa.gov/EPIC/api/natural/thumbnails?api_key=27auxknmyhmeGp4qkLBdLswd0UMoE6uP6kmHED3V'),
    );
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response and extract relevant information
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        earthImages = data.map<Map<String, dynamic>>((dynamic item) {
          // Extracting the relevant part from the identifier
          String extractedPart =
              '${item['identifier'].substring(0, 4)}/${item['identifier'].substring(4, 6)}/${item['identifier'].substring(6, 8)}/png/${item['image']}.png';

          // Constructing the URL with forward slashes
          String imageUrl =
              'https://epic.gsfc.nasa.gov/archive/natural/' + extractedPart;

          return {
            'image': imageUrl,
            'title': item['caption'],
            'date': item['identifier'],
          };
        }).toList();
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
        title: const Text('NASA Earth Images'),
      ),
      drawer: EarthVisorDrawer(
        onDrawerItemTap: (page) {
          // Handle navigation to each page
          // Implement the navigation logic based on the selected page

          Navigator.pop(context); // Close the drawer after selection
        },
      ),
      body: earthImages == null
          ? const Center(child: CircularProgressIndicator())
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
                builder: (context) => DetailPage(),
                settings: RouteSettings(
                  arguments: {
                    'image': earthImages![currentIndex]['image'],
                    'title': earthImages![currentIndex]['title'],
                    'date': earthImages![currentIndex]['date'],
                  },
                ),
              ),
            );
          },
          child: Container(
            height: 350,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: earthImages!.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                String heroTag = 'imageHero_${earthImages![index]['image']}';
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Hero(
                      tag: heroTag,
                      child: Image.network(
                        earthImages![index]['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 400,
          child: Text(
            earthImages![currentIndex]['title'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
        buildImageCarouselIndicator(),
        const SizedBox(height: 10),
        buildNavigationButtons(),
      ],
    );
  }

  Widget buildImageCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < earthImages!.length; i++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 7,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == i ? Colors.purple[400] : Colors.grey,
            ),
          ),
      ],
    );
  }

  Widget buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (currentIndex > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          },
          color: Colors.white,
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            if (currentIndex < earthImages!.length - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          },
          color: Colors.white,
        ),
      ],
    );
  }
}
