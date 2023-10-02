// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  ProfileCard(
      {super.key,
      required this.fullName,
      required this.username,
      required this.imageUrl,
      required this.bio});

  String fullName = '';
  String username = '';
  String imageUrl = '';
  String bio = '';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              foregroundImage: NetworkImage(imageUrl),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              fullName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '@$username',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary, fontSize: 20),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              height: 150,
              width: 400,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    bio,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
