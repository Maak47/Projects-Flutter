import 'package:earth_imagery_app/screens/home.dart';
import 'package:earth_imagery_app/screens/impressions.dart';
import 'package:earth_imagery_app/screens/profile.dart';
import 'package:earth_imagery_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  int updateCurrentIndex;
  BottomNav({super.key, required this.updateCurrentIndex});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.updateCurrentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: EarthVisorDrawer(
        onDrawerItemTap: (page) {},
      ),
      bottomNavigationBar: ClipRect(
        child: NavigationBar(
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_rounded), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.rate_review_rounded), label: 'Impressions'),
            NavigationDestination(
                icon: Icon(Icons.account_circle), label: 'Profile'),
          ],
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          elevation: 5,
          selectedIndex: currentIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
      body: [
        HomePage(),
        const Impressions(),
        Profile(),
      ][currentIndex],
    );
  }
}
