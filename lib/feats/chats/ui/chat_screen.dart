import 'dart:io';

import 'package:flutter/material.dart';
import 'package:free_chat/feats/auth/helpers/firebase_helpers.dart';
import 'package:free_chat/feats/auth/helpers/shared_pref.dart';
import 'package:free_chat/feats/auth/data/models/user_dm.dart';
import 'package:free_chat/feats/auth/presentation/screens/login_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundImage: FileImage(File(UserDM.currUser!.imagePath)),
        ),
        title: Text('Fast-Chat'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseHelpers.signOut();
              SharedPref.removeUser();
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
