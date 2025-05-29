import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:free_chat/feats/chats/ui/widgets/chat_msg_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text("Smth Went Wrong..."));
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return buildNoMsg();
        }

        return buildChatMessages(data: snapshot.data!.docs);
      },
    );
  }

  Widget buildChatMessages({
    required List<QueryDocumentSnapshot<Map<String, dynamic>>> data,
  }) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return ListView.builder(
      padding: EdgeInsets.only(bottom: 40, left: 13, right: 13),
      reverse: true,
      itemCount: data.length,

      itemBuilder: (context, index) {
        final chatMsg = data[index].data();
        final nextChatMsg =
            (index + 1 < data.length) ? data[index + 1].data() : null;
        final isSameUser =
            nextChatMsg != null && nextChatMsg['userId'] == chatMsg['userId'];

        if (!isSameUser) {
          return ChatMsgBubble.first(
            msg: chatMsg['text'],
            userImage: chatMsg['userImage'],
            userName: chatMsg['username'],
            isMe: userId == chatMsg['userId'],
          );
        }

        return ChatMsgBubble.next(
          msg: data[index].get('text'),
          isMe: userId == chatMsg['userId'],
        );
      },
    );
  }

  Center buildNoMsg() => Center(child: Text("No Msgs rn."));
}
