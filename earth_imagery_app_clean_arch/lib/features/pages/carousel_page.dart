import 'package:appwrite/appwrite.dart';
import 'package:earth_imagery_app/configs/constants/constants.dart';
import 'package:earth_imagery_app/features/pages/details_page.dart';
import 'package:earth_imagery_app/features/widgets/Image_carousel_indicator.dart';
import 'package:earth_imagery_app/features/widgets/navigation_buttons.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'dart:convert';

import '../../helpers/appwrite_service.dart' as service;

class CarouselPage extends StatefulWidget {
  const CarouselPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CarouselPageState createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>>? earthImages;
  int currentIndex = 0;
  late PageController _pageController;
  late TabController _tabController;
  late Databases databases;
  bool isAerosolActive = false;
  bool isCloudsActive = false;
  String convertedDate = '';
  List<String> timeZones = [
    'UTC',
    'America/New_York',
    'Europe/London',
    'Asia/Tokyo',
  ];

  String selectedTimeZone = 'UTC';

  final Client client = Client()
    ..setEndpoint('https://cloud.appwrite.io/v1')
    ..setProject('imageryappearth')
    ..setSelfSigned();

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.85,
    );

    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(() {
      fetchEarthImages(getApiForTab(_tabController.index));
    });

    fetchEarthImages(getApiForTab(_tabController.index));

    fetchUserPreferences();
  }

  Future<void> fetchUserPreferences() async {
    final user = await Account(client).get();
    final userId = user.$id;
    print(userId);

    final subscriptionStatus = await service.fetchUserPreferences(userId);
    await service.createDocument(userId);
    setState(() {
      isAerosolActive = subscriptionStatus?['isAerosolActive'] ?? false;
      isCloudsActive = subscriptionStatus?['isCloudsActive'] ?? false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _pageController.dispose();
  }

  String getApiForTab(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return 'natural';
      case 1:
        return 'enhanced';
      case 2:
        return 'aerosol';
      case 3:
        return 'cloud';
      default:
        return 'natural';
    }
  }

  Future<void> fetchEarthImages(String api) async {
    String apiUrl = 'https://epic.gsfc.nasa.gov/api/$api';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      // debugPrint(response.body);

      if (mounted) {
        // Check if the widget is still mounted before calling setState
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);

          setState(() {
            earthImages = data.map<Map<String, dynamic>>((dynamic item) {
              String extractedPart =
                  '${item['identifier'].substring(0, 4)}/${item['identifier'].substring(4, 6)}/${item['identifier'].substring(6, 8)}/png/${item['image']}.png';

              String imageUrl =
                  'https://epic.gsfc.nasa.gov/archive/$api/$extractedPart';

              return {
                'image': imageUrl,
                'title': item['caption'],
                'date': item['date'],
              };
            }).toList();
          });
        } else {
          // debugPrint('Failed to fetch earth images: ${response.statusCode}');
        }
      }
    } catch (error) {
      if (mounted) {
        // Check if the widget is still mounted before calling setState
        // debugPrint('Error fetching earth images: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: .1,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            const Tab(text: 'Natural'),
            const Tab(text: 'Enhanced'),
            if (isAerosolActive) const Tab(text: 'Aerosol'),
            if (isCloudsActive) const Tab(text: 'Cloud'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(4, (index) => buildEarthImageCarousel(index)),
      ),
    );
  }

  Widget buildEarthImageCarousel(int tabIndex) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            dropdownColor: kPrimaryColor,
            value: selectedTimeZone,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedTimeZone = newValue;
                });
              }
            },
            items: timeZones.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          GestureDetector(
            onTap: () {
              // Open detailed page when tapping on the current image
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailPage(),
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
            child: SizedBox(
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
                        //Caches Images so the images are not pulled from the backend after they are loaded.
                        child: CachedNetworkImage(
                          imageUrl: earthImages![index]['image'],
                          placeholder: (context, string) =>
                              const Center(child: CircularProgressIndicator()),
                          fit: BoxFit.cover,
                          fadeOutDuration: Duration.zero,
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
          ImageCarouselIndicator(
            currentIndex: currentIndex,
            earthImages: earthImages,
          ),
          const SizedBox(height: 10),
          NavigationButtons(
              earthImages: earthImages,
              currentIndex: currentIndex,
              pageController: _pageController),
        ],
      ),
    );
  }
}
