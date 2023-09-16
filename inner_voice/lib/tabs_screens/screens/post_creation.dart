import 'package:flutter/material.dart';

import '../widgets/quote_categories.dart';

class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({super.key});

  @override
  State<PostCreationScreen> createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  var textController = TextEditingController();
  var retainedText = '';
  var inEditMode = false;
  var applyColorToTheNextText = false;
  Color? fontColor;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PostCreation')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (!inEditMode)
                  ? Column(
                      children: [
                        AlertDialog(
                          content: TextField(
                            // onTapOutside: (event) {
                            //   setState(() {
                            //     inEditMode = !inEditMode;
                            //   });
                            // },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ), // fillColor: Colors.black),
                            textInputAction: TextInputAction.done,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            maxLines: 3,
                            controller: textController,
                            onChanged: (value) {
                              setState(() {
                                textController.text = value;
                              });
                            },

                            onEditingComplete: () {
                              setState(() {
                                applyColorToTheNextText = false;
                              });
                            },
                            onSubmitted: (value) {
                              setState(() {
                                textController.text = value;
                                inEditMode = !inEditMode;
                              });
                            },
                          ),
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    applyColorToTheNextText = true;
                                    fontColor = Colors.white;
                                    textController.text = '';
                                  });
                                },
                                icon: const Icon(
                                  Icons.circle,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    // textController.text = retainedText;
                                    applyColorToTheNextText = true;
                                    fontColor = Colors.amber;
                                    textController.text = '';
                                  });
                                },
                                icon: const Icon(
                                  Icons.circle,
                                  color: Colors.amber,
                                ))
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              if (retainedText.isNotEmpty) {
                                retainedText =
                                    retainedText + textController.text;
                              } else if (retainedText.isEmpty) {
                                retainedText = textController.text;
                              }
                              inEditMode = !inEditMode;
                            });
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('Done'),
                        ),
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          inEditMode = !inEditMode;
                        });
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.white)),
                              height: 400,
                              width: 400,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: retainedText,
                                      style: TextStyle(
                                        color: fontColor,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: textController.text,
                                      style: TextStyle(
                                        color: applyColorToTheNextText
                                            ? Colors.amber
                                            : Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextData extends StatelessWidget {
  TextData({super.key, this.inputText});

  String? inputText;
  Color? inputColor;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: inputText,
        style: TextStyle(color: inputColor),
      ),
    );
  }
}
