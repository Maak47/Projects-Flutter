import 'package:appwrite/appwrite.dart';
import 'package:earth_imagery_app/features/pages/subscription.dart';
import 'package:flutter/material.dart';

import '../../configs/constants/constants.dart';
import '../../helpers/appwrite_service.dart' as service;

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Client client = Client()
    ..setEndpoint('https://cloud.appwrite.io/v1')
    ..setProject('imageryappearth')
    ..setSelfSigned();
  bool isSubscribed = false;
  @override
  void initState() {
    super.initState();
    fetchUserPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: RadialGradient(
                radius: .70,
                center: Alignment.topCenter,
                colors: [
              Color(0xff2EC4B6),
              Color(0xff4b5886),
              Colors.transparent,
            ])),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const CircleAvatar(
                radius: 103,
                backgroundColor: Color(0x99ffffff),
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
              SizedBox(
                height: 20,
              ),
              (!isSubscribed)
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SubscribePage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.all(16.0),
                      ),
                      child: Text(
                        'Upgrade your Rank',
                        style: TextStyle(color: Colors.black),
                      ))
                  : ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.all(16.0),
                      ),
                      child: Text(
                        'Already Promoted',
                        style: TextStyle(color: kPrimaryColor),
                      )),
            ],
          )),
        ),
      ),
    );
  }

  TextStyle textStyle(double? fontSize) {
    return TextStyle(
        fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.bold);
  }

  Future<void> fetchUserPreferences() async {
    final user = await Account(client).get();
    final userId = user.$id;
    (userId);

    final subscriptionStatus = await service.fetchUserPreferences(userId);
    setState(() {
      isSubscribed = subscriptionStatus?['isSubscribed'] ?? false;
    });
  }
}
