import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/post.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        title: Container(
          child: SizedBox(
            width: 150,
            height: 50,
            child: Image.asset('assets/images/innervoice_logo.jpg'),
          ),
        ),
      ),
      body: const Center(
        child: Post(),
      ),
    );
  }
}
