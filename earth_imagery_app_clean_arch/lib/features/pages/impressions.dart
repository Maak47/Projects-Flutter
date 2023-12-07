import 'package:flutter/material.dart';

class Impressions extends StatelessWidget {
  const Impressions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Image.asset('assets/images/message.png'),
            const SizedBox(height: 5),
            const Text(
              'Impression/Kesan:',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const Text(
                'Saya mempelajari hal-hal baru dan menarik (ternyata ada yang lebih sensitif dari perasaan)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17)),
            const SizedBox(height: 10),
            const Text(
              'Message/Pesan:',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const Text(
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
