import 'package:flutter/material.dart';

import './screens/notifications.dart';
import './screens/post_creation.dart';
import './screens/search.dart';
import './screens/user_self_profile.dart';
import './screens/home.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ClipRRect(
          // borderRadius: const BorderRadius.only(
          //   topLeft: Radius.circular(20),
          //   topRight: Radius.circular(20),
          // ),
          // borderRadius: BorderRadius.all(Radius.circular(35)),
          child: NavigationBar(
            // indicatorShape: null,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            indicatorColor: Theme.of(context).colorScheme.primary,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            selectedIndex: currentPageIndex,
            destinations: const <Widget>[
              NavigationDestination(
                selectedIcon: Icon(Icons.home_rounded),
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.search),
                icon: Icon(Icons.search_rounded),
                label: 'Search',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.create_rounded),
                icon: Icon(Icons.create),
                label: 'Create',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.notifications_rounded),
                icon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.account_circle),
                icon: Icon(Icons.account_circle_outlined),
                label: 'Profile',
              )
            ],
          ),
        ),
        body: const <Widget>[
          HomeScreen(),
          SearchScreen(),
          PostCreationScreen(),
          NotificationsScreen(),
          UserSelfProfileScreen(),
        ][currentPageIndex]);
  }
}
