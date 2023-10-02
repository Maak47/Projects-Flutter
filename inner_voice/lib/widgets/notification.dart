import 'package:flutter/material.dart';

class PostNotification extends StatefulWidget {
  const PostNotification({super.key});

  @override
  State<PostNotification> createState() => _PostNotificationState();
}

class _PostNotificationState extends State<PostNotification> {
  var username = 'username';
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                  ),
                  title: Text(username),
                  trailing: Text(DateTime.now().toString()),
                ),
              ),
              Divider(
                thickness: .2,
              ),
            ],
          );
        });
  }
}
