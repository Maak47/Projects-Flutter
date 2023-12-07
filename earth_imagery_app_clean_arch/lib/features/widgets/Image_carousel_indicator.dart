import 'package:earth_imagery_app/configs/constants/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageCarouselIndicator extends StatelessWidget {
  final List<Map<String, dynamic>>? earthImages;
  int currentIndex;
  ImageCarouselIndicator(
      {super.key, required this.earthImages, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < (earthImages?.length ?? 0); i++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 7,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == i ? kAccentColor : Colors.grey,
            ),
          ),
      ],
    );
  }
}
