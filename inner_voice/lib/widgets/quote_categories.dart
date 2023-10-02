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
  int selectedCategoryIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
                width: 3,
              ),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: quoteCategories!.length,
          itemBuilder: (ctx, index) => InkWell(
                onTap: () {
                  setState(() {
                    selectedCategoryIndex = index;
                    widget.category = quoteCategories![index];
                  });
                  print(widget.category);
                },
                child: Container(
                  // width: 50,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedCategoryIndex == index
                          ? Colors.amber
                          : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    color: selectedCategoryIndex == index
                        ? Colors.amber
                        : Colors.black,
                  ),
                  child: Text(
                    quoteCategories![index],
                    style: TextStyle(
                        fontSize: 15,
                        color: selectedCategoryIndex == index
                            ? Colors.white
                            : Colors.amber),
                  ),
                ),
              )),
    );
  }
}
