import 'dart:io';

import 'package:flutter/material.dart';

class ChatMsgBubble extends StatelessWidget {
  const ChatMsgBubble.first({
    super.key,
    required this.msg,
    this.isMe = true,
    required String userImage,
    required String userName,
  }) : imgPath = userImage,
       username = userName,
       _isFirst = true;

  const ChatMsgBubble.next({super.key, required this.msg, this.isMe = true})
    : imgPath = null,
      username = null,
      _isFirst = false;

  final String msg;
  final bool isMe;
  final String? imgPath;
  final String? username;
  final bool _isFirst;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_isFirst && isMe)
          Positioned(
            top: 5,
            right: isMe ? null : 0,

            child: CircleAvatar(
              radius: 23,
              backgroundImage: FileImage(File(imgPath!)),
            ),
          ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: isMe ? 48 : 5),
          child: Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_isFirst) Text(username!),
                  SizedBox(width: 8),
                  msgBubble(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container msgBubble() {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 129, 129, 129),
        borderRadius: BorderRadius.only(
          topLeft: (isMe && _isFirst) ? Radius.zero : Radius.circular(12),
          topRight: (!isMe && _isFirst) ? Radius.zero : Radius.circular(12),

          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Text(msg),
    );
  }
}
