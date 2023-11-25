import 'package:earth_imagery_app/authservice.dart';
import 'package:earth_imagery_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final AuthService _authService = AuthService();
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'User Profile',
          ),
          actions: [
            IconButton(
                onPressed: () {
                  ElevatedButton(
                    onPressed: () {
                      _authService.signOut();
                    },
                    child: Text('Sign Out'),
                  );
                },
                icon: const Icon(Icons.login_rounded)),
          ]),
      drawer: EarthVisorDrawer(
        onDrawerItemTap: (page) {
          // Handle navigation to each page
          // Implement the navigation logic based on the selected page

          Navigator.pop(context); // Close the drawer after selection
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 140,
            ),
            const CircleAvatar(
              radius: 103,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/profpic.jpg'),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              'Rahmawati Dwi Augustin',
              style: textStyle(25),
            ),
            Text(
              '124210046 | PAM SI-C',
              style: textStyle(20),
            ),
            Text(
              'Bontang, 30th August 2003',
              style: textStyle(17),
            ),
            Text(
              'Hobby: Procrastinating',
              style: textStyle(20),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        )),
      ),
    );
  }

  TextStyle textStyle(double? fontSize) {
    return TextStyle(
        fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.bold);
  }
}
