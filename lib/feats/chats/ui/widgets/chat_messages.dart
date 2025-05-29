import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("No Msgs rn."));

    // StreamBuilder(stream: , builder: (context, snapshot) { },);
  }
}
