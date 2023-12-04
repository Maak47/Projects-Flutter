import 'package:earth_imagery_app_clean_arch/configs/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarouselPage extends StatefulWidget {
  @override
  _CarouselPageState createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>>? earthImages;
  int currentIndex = 0;
  late PageController _pageController;
  late TabController _tabController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // Fetch earth images from NASA EPIC API
    fetchEarthImages('natural');

    // Initialize PageController
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.85, // Set a custom viewportFraction
    );

    // Initialize TabController
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        isLoading = true;
      });
      switch (_tabController.index) {
        case 0:
          fetchEarthImages('natural');
          break;
        case 1:
          fetchEarthImages('enhanced');
          break;
        case 2:
          fetchEarthImages('aerosol');
          break;
        case 3:
          fetchEarthImages('cloud');
          break;
      }
    });
  }

  Future<void> fetchEarthImages(String api) async {
    String apiUrl = 'https://epic.gsfc.nasa.gov/api/$api';

    final response = await http.get(
      Uri.parse(apiUrl),
    );

    setState(() {
      isLoading = false;
    });

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
              'https://epic.gsfc.nasa.gov/archive/$api/' + extractedPart;

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
        backgroundColor:
            Colors.transparent, // Set the background color to transparent

        toolbarHeight: .1,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Natural'),
            Tab(text: 'Enhanced'),
            Tab(text: 'Aerosol'),
            Tab(text: 'Cloud'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildEarthImageCarousel(), // Natural
          buildEarthImageCarousel(), // EPI
          buildEarthImageCarousel(), // Aerosol
          buildEarthImageCarousel(), // Cloud
        ],
      ),
    );
  }

  Widget buildEarthImageCarousel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) CircularProgressIndicator(),
        if (!isLoading)
          GestureDetector(
            onTap: () {
              // Open detailed page when tapping on the current image
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => DetailPage(),
              //     settings: RouteSettings(
              //       arguments: {
              //         'image': earthImages![currentIndex]['image'],
              //         'title': earthImages![currentIndex]['title'],
              //         'date': earthImages![currentIndex]['date'],
              //       },
              // ),
              // ),
              // );
            },
            child: Container(
              height: 350,
              width: double.infinity,
              child: PageView.builder(
                controller: _pageController,
                itemCount: earthImages?.length ?? 0,
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
            earthImages?[currentIndex]['title'] ?? '',
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
        for (int i = 0; i < (earthImages?.length ?? 0); i++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 7,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  currentIndex == i ? AppConstants().kAccentColor : Colors.grey,
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
            if (currentIndex < (earthImages?.length ?? 0) - 1) {
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

  // Future<void> fetchEarthImages() async {
  //   final response = await http.get(
  //     Uri.parse('https://epic.gsfc.nasa.gov/api/enhanced'),
  //   );
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     // Parse the JSON response and extract relevant information
  //     final List<dynamic> data = json.decode(response.body);

  //     setState(() {
  //       earthImages = data.map<Map<String, dynamic>>((dynamic item) {
  //         // Extracting the relevant part from the identifier
  //         String extractedPart =
  //             '${item['identifier'].substring(0, 4)}/${item['identifier'].substring(4, 6)}/${item['identifier'].substring(6, 8)}/png/${item['image']}.png';

  //         // Constructing the URL with forward slashes
  //         String imageUrl =
  //             'https://epic.gsfc.nasa.gov/archive/enhanced/' + extractedPart;

  //         return {
  //           'image': imageUrl,
  //           'title': item['caption'],
  //           'date': item['identifier'],
  //         };
  //       }).toList();
  //     });
  //   } else {
  //     // Handle error
  //     print('Failed to fetch earth images: ${response.statusCode}');
  //   }
  // }
}
