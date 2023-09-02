import 'package:flutter/material.dart';

class QuoteCategories extends StatefulWidget {
  QuoteCategories({super.key, required this.category});
  String? category = '';

  @override
  State<QuoteCategories> createState() => _QuoteCategoriesState();
}

class _QuoteCategoriesState extends State<QuoteCategories> {
  final List? quoteCategories = [
    'Alone',
    'Attitude',
    'Best',
    'Life',
    'Friendship',
    'Happiness',
    'inspirational',
    'Leadership',
    'Life',
    'Love',
    'Motivational',
    'Nature',
    'Positive',
    'Reading',
    'Relationship',
    'Smile',
    'Strength',
    'Success',
    'Time',
    'Trust',
    'Wisdom',
    'Woman',
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: quoteCategories!.length,
        itemBuilder: (ctx, index) => Row(
          children: [
            OutlinedButton(
                onPressed: () {
                  widget.category = quoteCategories![index];

                  // print(category);
                },
                child: Text(quoteCategories![index])),
            SizedBox(
              width: 5,
            )
          ],
        ),
      ),
    );
  }
}
