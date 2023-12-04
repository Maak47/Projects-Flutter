import 'package:earth_imagery_app_clean_arch/configs/constants/constants.dart';
import 'package:earth_imagery_app_clean_arch/features/auth/presentation/pages/auth_page.dart';
import 'package:earth_imagery_app_clean_arch/features/auth/presentation/pages/carousel_page.dart';
import 'package:earth_imagery_app_clean_arch/features/auth/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class MainPage extends StatefulWidget {
  final String username;

  const MainPage({Key? key, required this.username}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final constants = AppConstants();
  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

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
        backgroundColor: constants.kBackgroundColor,
        title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Hey, ${widget.username}'), Text("Let's Explore")]),
        toolbarHeight: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20),
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
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: SnakeNavigationBar.gradient(
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,

        ///configuration for SnakeNavigationBar.color
        // snakeViewColor: selectedColor,
        // selectedItemColor:
        //     snakeShape == SnakeShape.indicator ? selectedColor : null,
        // unselectedItemColor: Colors.blueGrey,

        snakeViewGradient: selectedGradient,
        selectedItemGradient:
            snakeShape == SnakeShape.indicator ? selectedGradient : null,
        unselectedItemGradient: unselectedGradient,

        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,

        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: [
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
        return CarouselPage();
      case 1:
        return _buildMessages();
      case 2:
        return ProfilePage();
      default:
        return Container();
    }
  }

  Widget _buildHome() {
    return Center(
      child: Text('Home Page'),
    );
  }

  Widget _buildMessages() {
    return Center(
      child: Text('Messages Page'),
    );
  }
}
