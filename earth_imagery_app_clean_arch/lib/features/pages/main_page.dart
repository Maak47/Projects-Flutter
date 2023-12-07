import 'dart:ui';

import 'package:earth_imagery_app/configs/constants/constants.dart';
import 'package:earth_imagery_app/features/pages/carousel_page.dart';
import 'package:earth_imagery_app/features/pages/impressions.dart';
import 'package:earth_imagery_app/features/pages/profile_page.dart';
import 'package:earth_imagery_app/features/widgets/drawer.dart';
import 'package:earth_imagery_app/helpers/appwrite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class MainPage extends StatefulWidget {
  final String username;

  const MainPage({Key? key, required this.username}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25), topRight: Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.pinned;
  EdgeInsets padding = const EdgeInsets.all(12);

  int _selectedItemPosition = 0;
  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Colors.black;
  Color unselectedColor = Colors.amber;

  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);
  Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  Color? containerColor;
  List<Color> containerColors = [
    const Color(0xFFFDE1D7),
    const Color(0xFFE4EDF5),
    const Color(0xFFE7EEED),
    const Color(0xFFF4E4CE),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Cadet, ${widget.username}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const Text(
            "Let's EXPLORE 🚀",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff2EC4B6)),
          )
        ]),
        toolbarHeight: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedItemPosition = 2;
                });
              },
              child: (_selectedItemPosition == 2)
                  ? IconButton(
                      onPressed: () {
                        logout(context);
                      },
                      icon: const Icon(
                        Icons.logout_rounded,
                        size: 30,
                      ),
                      color: kAccentColor,
                    )
                  : CircleAvatar(
                      radius: 26,
                      backgroundColor: kAccentColor,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.asset(
                          'assets/images/profpic.jpg',
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
      drawer: ThemedDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/scaffold_background.jpg'),
                    fit: BoxFit.fill)),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: .45, sigmaY: .45),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          _buildBody(),
        ],
      ),
      bottomNavigationBar: SnakeNavigationBar.gradient(
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,
        snakeViewGradient: selectedGradient,
        selectedItemGradient:
            snakeShape == SnakeShape.indicator ? selectedGradient : null,
        unselectedItemGradient: unselectedGradient,
        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedItemPosition) {
      case 0:
        return const CarouselPage();
      case 1:
        return const Impressions();
      case 2:
        return const ProfilePage();
      default:
        return Container();
    }
  }
}
