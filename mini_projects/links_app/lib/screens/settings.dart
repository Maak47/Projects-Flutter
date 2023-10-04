import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './login.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'App Usage Instructions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Welcome to our Flutter application! This app is designed to help you manage members, time with a stopwatch, and access recommended sites easily. Here\'s how to use it:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '1. Home Tab',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                '- The Home tab is your main dashboard, where you can access various features.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'A. Members List:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                '''
    - View a list of members.
    - Add Users with the FloatingActionButton,
    - Delete Users with the Delete Icon.
                ''',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                'B. StopWatch:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                '''
    - This is a Timer based StopWatch.
    - Press Start to start the timer,
    - Press Stop to Stop the timer,
    - Press Reset to reset the timer.
                ''',
                style: TextStyle(fontSize: 14),
              ),

              Text(
                'C. Recommended Sites:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                '''
    - This is the Recommended Sites page.
    - Press on the individual tile to open up the website.
    - Press the heart-icon to mark the site as Favourite.
                ''',
                style: TextStyle(fontSize: 14),
              ),

              Text(
                'D. Favourites:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                '''
    - This is the Favourites page.
    - All the sites marked as favourite in, 
      the Recommended sites page as displayed here.
    - Press on the individual tile to open up the website.
                ''',
                style: TextStyle(fontSize: 14),
              ),

              // Add more instructions for each feature as needed

              SizedBox(height: 20),
              Text(
                '2. Settings Tab',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                '- Click on the "Settings" tab to access app settings and information.',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _logout(context);
        },
        child: Icon(Icons.logout),
      ),
    );
  }

  _logout(BuildContext context) async {
    // Clear user credentials (e.g., username and password) from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('password');

    // Navigate the user back to the login screen
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false, // Clear the navigation stack
    );
  }
}
