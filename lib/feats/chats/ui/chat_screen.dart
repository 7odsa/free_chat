import 'package:flutter/material.dart';
import 'package:free_chat/feats/auth/helpers/firebase_helpers.dart';
import 'package:free_chat/feats/auth/presentation/screens/login_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fast-Chat'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseHelpers.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [buildNoMsg()],
      ),
    );
  }

  Widget buildNoMsg() {
    return Center(child: Text("No Messages Found..."));
  }
}
