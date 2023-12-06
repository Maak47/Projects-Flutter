import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NavigationButtons extends StatelessWidget {
  final List<Map<String, dynamic>>? earthImages;
  int currentIndex = 0;
  late final PageController pageController;

  NavigationButtons(
      {super.key,
      required this.earthImages,
      required this.pageController,
      required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (currentIndex > 0) {
              pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          },
          color: Colors.white,
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            if (currentIndex < (earthImages?.length ?? 0) - 1) {
              pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          },
          color: Colors.white,
        ),
      ],
    );
  }
}
