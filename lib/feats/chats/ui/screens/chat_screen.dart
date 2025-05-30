import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:free_chat/feats/auth/helpers/firebase_helpers.dart';
import 'package:free_chat/feats/auth/helpers/shared_pref.dart';
import 'package:free_chat/feats/chats/ui/widgets/chat_messages.dart';
import 'package:free_chat/feats/chats/ui/widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    setupPushNotification();
  }

  void setupPushNotification() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();

    fcm.subscribeToTopic('chat');

    final token = await fcm.getToken();

    print('token:           $token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: Text('Fast-Chat'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseHelpers.signOut();
              SharedPref.removeUser();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [Expanded(child: ChatMessages()), NewMessage()],
      ),
    );
  }

  Widget buildNoMsg() {
    return Center(child: Text("No Messages Found..."));
  }
}
