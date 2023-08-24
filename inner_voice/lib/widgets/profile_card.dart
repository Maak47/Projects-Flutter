import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    String? imageUrl =
        'https://yt3.googleusercontent.com/ytc/AOPolaQU7d-76h4CdweblIAur6EtN__S1OXe6PMxaW9yfA=s900-c-k-c0x00ffffff-no-rj';
    String? userName = 'Name Name';
    int? userTotalPosts = 0;
    int? userFollowers = 0;
    int? userFollowing = 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          userName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 0,
        ),
        const Divider(),
      ],
    );
  }
}
