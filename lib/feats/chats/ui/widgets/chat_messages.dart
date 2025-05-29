import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    // return

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
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 40, left: 13, right: 13),
      reverse: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Text(data[index].get('text'));
      },
    );
  }

  Center buildNoMsg() => Center(child: Text("No Msgs rn."));
}
