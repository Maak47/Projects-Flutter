import 'package:flutter/material.dart';
import 'package:train_station_app/screens/home.dart';
import 'package:train_station_app/screens/members.dart';
import 'package:train_station_app/screens/stations.dart';

class BottomNav extends StatefulWidget {
  BottomNav({
    super.key,
  });

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRect(
        child: NavigationBar(
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_rounded), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.train_rounded), label: 'Stations'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Members'),
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
        HomeScreen(),
        StationsScreen(),
        MembersScreen(),
      ][currentIndex],
    );
  }
}
