import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:scribbles/widgets/chat_messages.dart';
import 'package:scribbles/widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();

    // ignore: unused_local_variable
    final token = await fcm.getToken();
    fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();

    setupPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scribbles'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.exit_to_app_outlined,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
      body: const Column(
        children: [
          Expanded(child: ChatMessages()),
          NewMessage(),
        ],
      ),
    );
  }
}
