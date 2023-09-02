import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inner_voice/tabs_screens/tabs.dart';

class UserSelfProfileScreen extends StatefulWidget {
  const UserSelfProfileScreen({super.key});

  @override
  State<UserSelfProfileScreen> createState() => _UserSelfProfileScreenState();
}

class _UserSelfProfileScreenState extends State<UserSelfProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Profile')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: const CircularProgressIndicator());
          }
          final data = snapshot.data!.data();

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
            child: SingleChildScrollView(
              child: Center(
                  child: Column(
                children: [
                  CircleAvatar(
                    radius: 62,
                    backgroundColor: Colors.amber,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        data!['profile_image_url'],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '@${data['username']}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    data['fullname'],
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: Card(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          data['bio'],
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: .2,
                  ),
                ],
              )),
            ),
          );
        },
      ),
    );
  }
}
