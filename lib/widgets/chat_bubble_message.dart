import 'package:custom_chat_gpt/utilities/APP_CODES.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';

import '../utilities/colors.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String isMe;
  final String time;

  const ChatBubble({super.key, required this.message, required this.isMe, required this.time});

  @override
  Widget build(BuildContext context) {

      return Align(
        alignment: isMe == AppCodes.CHAT_USER
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: isMe == AppCodes.CHAT_USER ? CrossAxisAlignment
              .end : CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              constraints: BoxConstraints(maxWidth: MediaQuery
                  .of(context)
                  .size
                  .width * 0.85),
              decoration: BoxDecoration(
                color: isMe == AppCodes.CHAT_USER
                    ? Color(0xFF007AFF)
                    : ColorPrimary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(
                      isMe == AppCodes.CHAT_USER ? 16 : 0),
                  bottomRight: Radius.circular(
                      isMe == AppCodes.CHAT_USER ? 0 : 16),
                ),
              ),
              child: MarkdownBody(
               data:  message,

                styleSheet: MarkdownStyleSheet(
                  p: TextStyle(fontSize: 15,  color: isMe == AppCodes.CHAT_USER ? Colors.white : Colors.white, ),
                  strong: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isMe == AppCodes.CHAT_USER ? Colors.white : Colors.white,

                  ),
                ),
              ),

              ),

            Text(
            DateFormat('dd MMM yyyy, hh:mm a')
                .format(DateTime.parse(time)), style: const TextStyle(fontSize: 10, color: Colors.grey)),
            const SizedBox(height: 8),
          ],
        ),
      );
    }
  }
