import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: RadialGradient(
                radius: .70,
                center: Alignment.topCenter,
                colors: [
              Colors.greenAccent,
              Color(0xff4b5886),
              Colors.transparent,
            ])),
        child: Padding(
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
      ),
    );
  }

  TextStyle textStyle(double? fontSize) {
    return TextStyle(
        fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.bold);
  }
}
