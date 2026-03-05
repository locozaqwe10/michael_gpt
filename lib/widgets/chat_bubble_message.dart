import 'package:custom_chat_gpt/utilities/APP_CODES.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../utilities/colors.dart';
import '../utilities/hive/user_hive_model.dart';
import 'circular_letter_avatar.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String isMe;
  final String time;
  final String firstName;

  const ChatBubble({super.key, required this.message, required this.isMe, required this.time, required this.firstName});

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
            Row(
              mainAxisAlignment: isMe == AppCodes.CHAT_USER ?MainAxisAlignment.end:MainAxisAlignment.start,
              children: [

                Visibility(
                  visible:isMe == AppCodes.CHAT_USER ? false:true,
                  child: CircleAvatar(
                    backgroundColor: ColorBgBlock,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: FaIcon(
                        FontAwesomeIcons.robot,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
SizedBox(width: 10,),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      constraints: BoxConstraints(maxWidth: MediaQuery
                          .of(context)
                          .size
                          .width * 0.75),
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
                        fitContent: true,

                        styleSheet: MarkdownStyleSheet(
                          p: TextStyle(fontSize: 15,  color: isMe == AppCodes.CHAT_USER ? Colors.white : Colors.white, ),
                          strong: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isMe == AppCodes.CHAT_USER ? Colors.white : Colors.white,

                          ),
                        ),
                      ),

                      ),
                  ],
                ),
                SizedBox(width: 10,),
                Visibility(visible:isMe == AppCodes.CHAT_USER ? true:false ,child:  Visibility(child:  circularAvatar(name: firstName, radius: 20),)),

              ],
            ),

            Align(
              alignment: isMe == AppCodes.CHAT_USER ?Alignment.bottomRight: Alignment.bottomLeft,
              child: Container(
                margin: isMe == AppCodes.CHAT_USER ? EdgeInsets.only(right: 50) :EdgeInsets.only(left: 50),
                child: Text(
                DateFormat('dd MMM yyyy, hh:mm a')
                    .format(DateTime.parse(time)), style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    }


  }


