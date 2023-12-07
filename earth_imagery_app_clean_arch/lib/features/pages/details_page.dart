import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:http/http.dart' as http;
import '../models/image_metadata.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<String> saveImageLocally(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      final bytes = response.bodyBytes;

      final directory = await getExternalStorageDirectory();
      final filePath =
          '${directory!.path}/${DateTime.now().millisecondsSinceEpoch}.png';

      await File(filePath).writeAsBytes(bytes);
      print('FilePath: $filePath');

      return filePath;
    } catch (e) {
      print('Error saving image locally: $e');
      return ''; // Handle error appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    String heroTag = 'imageHero_${args['image']}';

    Future<void> saveToGallery() async {
      try {
        final box = await Hive.openBox<ImageMetadata>('imageMetadata');
        final localFilePath = await saveImageLocally(args['image']);
        final imageMetadata = ImageMetadata(
            imageUrl: args['image'], localFilePath: localFilePath);
        box.add(imageMetadata);
        await box.close();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image saved to gallery.'),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (e) {
        print('Error saving to gallery: $e');
        // Handle error appropriately
      }
    }

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
          ),
          Positioned(
            right: 10,
            top: 90,
            child: ElevatedButton.icon(
              label: const Text('Save to Phone'),
              onPressed: saveToGallery,
              icon: const Icon(Icons.download_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
