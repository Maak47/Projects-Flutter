import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final form = GlobalKey<FormState>();
  var isFavorite = false;
  var isBookmarked = false;
  var onTapComment = false;
  var commentIndex = 2;
  var username = 'username';
  var comment = '';
  var commentController = TextEditingController();

  void snackBar(String action) {
    String? message;
    ScaffoldMessenger.of(context).clearSnackBars();

    switch (action) {
      case 'comment':
        message = 'Added comment';
        break;
      case 'bookmark':
        message = 'Added bookmark';
        break;
      case 'like':
        message = (isFavorite) ? 'Added a like' : 'Removed a like';
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message!)),
    );
  }

  void submit() async {
    form.currentState!.save();
    If(isBookmarked) {}
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (ctx, index) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
              ),
              title: Text(
                "Name Name",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: const Text(
                'Time',
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ),
            Container(height: 400),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  label: const Text('0'),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                      snackBar('like');
                    });
                  },
                  icon: !isFavorite
                      ? const Icon(Icons.favorite_border_rounded)
                      : const Icon(
                          Icons.favorite_rounded,
                          color: Colors.amber,
                        ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  label: Text(commentIndex.toString()),
                  onPressed: () {
                    setState(() {
                      onTapComment = !onTapComment;
                    });
                  },
                  icon: const Icon(Icons.mode_comment_rounded),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                ),
                ElevatedButton(
                  // label: const Text(''),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isBookmarked = !isBookmarked;
                    });
                  },
                  child: !isBookmarked
                      ? const Icon(Icons.bookmark_outline_rounded)
                      : const Icon(
                          Icons.bookmark_rounded,
                          color: Colors.amber,
                        ),
                ),
              ],
            ),
            (onTapComment)
                ? Container(
                    padding: EdgeInsets.all(5),
                    height: 100,
                    color: Color.fromARGB(255, 31, 31, 31),
                    child: ListView.builder(
                      itemCount: commentIndex,
                      itemBuilder: (ctx, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${username} ${comment}'),
                            Divider(thickness: .2),
                          ],
                        );
                      },
                    ),
                  )
                : Divider(
                    color: Colors.grey[800],
                  ),
            (onTapComment)
                ? Column(
                    children: [
                      TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffix: TextButton(
                              onPressed: submit, child: Text('Post')),
                          hintText: 'add a comment...',
                        ),
                        controller: commentController,
                        onSaved: (value) {
                          comment = value!;
                        },
                      ),
                      Divider(
                        color: Colors.grey[800],
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        );
      },
    );
  }
}
