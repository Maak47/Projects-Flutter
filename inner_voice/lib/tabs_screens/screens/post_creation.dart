import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../widgets/quote_categories.dart';

class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({super.key});

  @override
  State<PostCreationScreen> createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  var textController = TextEditingController();
  var selectedCategory = '';

  void _printLatestValue() {
    final text = textController.text;
    print('Second text field: $text (${text.characters.length})');
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    textController.addListener(_printLatestValue);
    print(selectedCategory);
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Post')),
      body: Padding(
        padding: EdgeInsets.all(18.0),
        child: Center(
            child: Column(
          children: [
            QuoteCategories(
              category: selectedCategory,
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                // showDialog(context: context, builder: (context) {});
              },
              child: Container(
                alignment: Alignment.center,
                // color: Colors.black,
                height: 500,
                width: double.infinity,
                child: Text(
                  'Start writing your heart out...',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
