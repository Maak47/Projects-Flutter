import 'package:appwrite/appwrite.dart';
import 'package:earth_imagery_app/features/pages/details_page.dart';
import 'package:earth_imagery_app/features/widgets/Image_carousel_indicator.dart';
import 'package:earth_imagery_app/features/widgets/navigation_buttons.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
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
  bool isAerosolTabLocked = false;
  bool isCloudsTabLocked = false;
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

    databases = Databases(Client());
    fetchUserPreferences();
  }

  Future<void> fetchUserPreferences() async {
    final user = await Account(client).get();
    final userId = user.$id;
    print(userId);

    final subscriptionStatus = await service.fetchUserPreferences(userId);
    setState(() {
      isAerosolTabLocked = subscriptionStatus?['isAerosolTabLocked'] ?? false;
      isCloudsTabLocked = subscriptionStatus?['isCloudsTabLocked'] ?? false;
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
      debugPrint(response.body);

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
          debugPrint('Failed to fetch earth images: ${response.statusCode}');
        }
      }
    } catch (error) {
      if (mounted) {
        // Check if the widget is still mounted before calling setState
        debugPrint('Error fetching earth images: $error');
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
            Tab(text: 'Natural'),
            Tab(text: 'Enhanced'),
            if (!isAerosolTabLocked) Tab(text: 'Aerosol'),
            if (!isCloudsTabLocked) Tab(text: 'Cloud'),
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
