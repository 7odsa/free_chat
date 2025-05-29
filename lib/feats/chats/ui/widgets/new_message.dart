import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:free_chat/feats/auth/data/models/user_dm.dart';
import 'package:free_chat/feats/auth/helpers/firestore_helpres.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final msgController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    msgController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: msgController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(labelText: 'Send a Msg...'),
            ),
          ),
          IconButton(
            onPressed: _submitMsg,
            icon: Icon(Icons.send_rounded),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }

  void _submitMsg() async {
    final enteredMsg = msgController.text;

    if (enteredMsg.trim().isEmpty) return;

    FocusScope.of(context).unfocus();
    msgController.clear();

    if (UserDM.currUser == null) {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      UserDM.currUser = await FirestoreHelpres().getUser(userId);
    }

    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMsg,
      'createdAt': Timestamp.now(),
      'userId': UserDM.currUser!.id,
      'username': UserDM.currUser!.username,
      'userImage': UserDM.currUser!.imagePath,
    });
  }
}
