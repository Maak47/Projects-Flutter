import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    String heroTag = 'imageHero_${args['image']}';

    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: heroTag,
            child: Image.network(
              args['image'],
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Positioned(
            top: 60,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_rounded)),
          ),
          Positioned(
            bottom: 40,
            left: 10,
            child: SizedBox(
              width: 400,
              child: Text(
                args['title'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: 70,
            right: 10,
            child: Text(
              "${args['date'].substring(6, 8)}-${args['date'].substring(4, 6)}-${args['date'].substring(0, 4)}",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
