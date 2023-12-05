import 'package:flutter/material.dart';
import '../../configs/constants/constants.dart';

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
              color:
                  currentIndex == i ? AppConstants().kAccentColor : Colors.grey,
            ),
          ),
      ],
    );
  }
}
