import 'package:flutter/material.dart';
import 'package:inner_voice/tabs_screens/widgets/notification.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: const Center(
        child: PostNotification(),
      ),
    );
  }
}
