import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

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
          PhotoView(
            heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
            imageProvider: NetworkImage(
              args['image'],
            ),
          ),
          Positioned(
            top: 60,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded)),
          ),
          Positioned(
            bottom: 40,
            left: 10,
            child: SizedBox(
              width: 400,
              child: Text(
                args['title'],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: 70,
            right: 10,
            child: Text(
              args['date'],
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
