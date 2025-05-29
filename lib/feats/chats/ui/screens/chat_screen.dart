import 'package:flutter/material.dart';
import 'package:free_chat/feats/auth/helpers/firebase_helpers.dart';
import 'package:free_chat/feats/auth/helpers/shared_pref.dart';
import 'package:free_chat/feats/chats/ui/widgets/chat_messages.dart';
import 'package:free_chat/feats/chats/ui/widgets/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
