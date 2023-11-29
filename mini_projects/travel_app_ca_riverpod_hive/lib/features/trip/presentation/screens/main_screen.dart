import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app_ca_riverpod_hive/features/trip/presentation/screens/add_trip_screen.dart';
import 'package:travel_app_ca_riverpod_hive/features/trip/presentation/screens/my_trips_screen.dart';

class MainScreen extends ConsumerWidget {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String profilePhoto =
        'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
    _pageController.addListener(() {
      _currentPage.value = _pageController.page!.round();
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi Rahu 👋',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Traveling Today?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                profilePhoto,
                fit: BoxFit.cover,
                height: 60,
                width: 60,
              ),
            ),
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: [
          MyTripsScreen(),
          AddTripScreen(),
          Center(
            child: Text('3'),
          ),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _currentPage,
        builder: (context, pageIndex, child) => BottomNavigationBar(
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
          currentIndex: pageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'My Trips',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Trip',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
          ],
        ),
      ),
    );
  }
}
