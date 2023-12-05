import 'package:flutter/material.dart';

class Impressions extends StatelessWidget {
  const Impressions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Padding(
      padding: EdgeInsets.all(15.0),
      child: Center(
        child: Column(
          children: [
            // SizedBox(height: 60),
            // Image.asset('assets/images/mobile.png'),
            SizedBox(height: 10),
            Text(
              'Impression/Kesan:',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            Text(
                'Saya mempelajari hal-hal baru dan menarik (ternyata ada yang lebih sensitif dari perasaan)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17)),
            SizedBox(height: 10),
            Text(
              'Message/Pesan:',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            Text(
              'Pengen bisa ngoding flutter sambil merem',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    ));
  }
}
