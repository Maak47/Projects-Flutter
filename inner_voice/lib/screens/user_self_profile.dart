import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:inner_voice/screens/tabs.dart';
import 'package:inner_voice/widgets/profile_card.dart';
import 'package:inner_voice/widgets/profile_post_grid.dart';

class UserSelfProfileScreen extends StatefulWidget {
  const UserSelfProfileScreen({super.key});

  @override
  State<UserSelfProfileScreen> createState() => _UserSelfProfileScreenState();
}

class _UserSelfProfileScreenState extends State<UserSelfProfileScreen> {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          actions: <Widget>[
            IconButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: const Icon(Icons.exit_to_app))
          ],
          leading: BackButton(
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => const TabScreen())),
          ),
          title: const Text('User Profile')),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(children: [
            ProfileCard(),
            ProfilePostGrid(),
          ]),
        ),
      ),
    );
  }
}
