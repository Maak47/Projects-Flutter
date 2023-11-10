import 'package:flutter/material.dart';
import 'package:shapes/screens/home.dart';
import 'package:shapes/screens/profile.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon:Icon(Icons.home_rounded),
            label: 'Main',
          ),

          NavigationDestination(

            icon: Icon(Icons.account_box_outlined),
            selectedIcon: Icon(Icons.circle),
            label: 'Personal',
          ),
        ],

        selectedIndex: currentPageIndex,



      ),
      body:  <Widget>[
     const HomeScreen(),
       const  ProfileScreen(),

      ][currentPageIndex],
    );
  }
}
