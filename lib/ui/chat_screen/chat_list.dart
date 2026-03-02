import 'dart:convert';

import 'package:custom_chat_gpt/routes/routes_name.dart';
import 'package:custom_chat_gpt/ui/chat_screen/chat_screen_viewmodel.dart';
import 'package:custom_chat_gpt/utilities/APP_CODES.dart';
import 'package:custom_chat_gpt/utilities/colors.dart';
import 'package:custom_chat_gpt/utilities/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../model/chat_list_model.dart';
import '../../model/general_response.dart';
import '../../utilities/hive/user_hive_model.dart';
import '../../widgets/chat_bubble_message.dart';

class ChatList extends StatefulWidget {
  int refresh ;
   ChatList( this.refresh, {super.key} ) ;

  @override
  _ChatList createState() => _ChatList();
}

class _ChatList extends State <ChatList> {
  final List<ChatMessage> messages = [];
  int SessionID = -1;
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  late Box userBox;
  ChatScreenViewmodel viewmodel = ChatScreenViewmodel();
  late UserHiveModel hiveUser;
  bool isWaitingResponse = false;
  int refresh = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    addChatSession();

  }

  @override
  Widget build(BuildContext context) {

    if (widget.refresh != refresh){
      refresh = widget.refresh;
      messages.clear();
      setState(() {

      });
    }
      return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        if (messages.length>0)...[
        Container(
          height: MediaQuery.of(context).size.height - 200,
          child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: messages.length + (isWaitingResponse ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < messages.length) {
                final msg = messages[index];
                return ChatBubble(
                  message: msg.message,
                  isMe: msg.isMe,
                  time: msg.time.toString(),

                );
              } else {
                // Loading bubble at bottom
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      CircularProgressIndicator(strokeWidth: 2),
                      const SizedBox(width: 10),
                      const Text("Thinking..."),
                    ],
                  ),
                );
              }
            },
          ),
        ),
]else... [

  Container(
    height: MediaQuery.of(context).size.height-200,
    margin: EdgeInsets.only(left: 10, right: 10),
    child: Column(

      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/logo_nobg.png", ),
        Text("Ask Michael, Your AI Sidekick. Built ",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),),
        Text(" by Michael Dermer", style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
          color: Colors.grey
    ),),
        SizedBox(height: 10,),
        Text("Michael GPT is an AI Sidekick built on the same underlying technology as ChatGPT, but trained specifically on Michael Dermer’s experience, judgment, and TLE’s Survival System. \nIt helps founders decide what matters in the moment — when the stakes are real and guessing is expensive.",
        textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 12),
        )
      ],
    ),
  ),
        ],
        Container(
          margin: EdgeInsets.all(8),
        decoration:  BoxDecoration(
            color: CupertinoColors.systemGrey2,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          border: BoxBorder.all(color: Colors.black, style: BorderStyle.solid,width: 2)
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,

                    decoration: const InputDecoration(
                      hintText: "Ask Michael...",
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value){
                      _sendMessage(controller.text.trim());
                    },
                  ),
                ),
                IconButton(icon: const Icon(Icons.send), onPressed:() {_sendMessage(controller.text.trim());}),
              ],
            ),
          ),
        ),

      ],
    );
  }

  Future<void> _sendMessage(String question) async {

    if (question.isEmpty) return;

    controller.clear();

    setState(() {
      messages.add(
        ChatMessage(
          message: question,
          isMe: AppCodes.CHAT_USER,
          time: DateTime.now(), errorMessage: '',
        ),
      );
      isWaitingResponse = true;
    });

    _scrollToBottom();

    // 🔥 CALL YOUR LLM API HERE
    final response = await callLLM(question);

    if (response.code == 200) {
      setState(() {
        String data = jsonDecode(response.data["llm_response"])["output"];
        isWaitingResponse = false;
        messages.add(
          ChatMessage(
            message: data,
            isMe: AppCodes.CHAT_BOT,
            time: DateTime.now(),
            errorMessage: "",
          ),
        );
      });

      _scrollToBottom();
    } else {
      isWaitingResponse = false;
      messages.add(
        ChatMessage(
          message: response.message,
          isMe: AppCodes.CHAT_BOT,
          time: DateTime.now(),
          errorMessage: "",
        ),
      );
      setState(() {

      });
      showPremiumDialog(context);
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Future<GeneralResponse> callLLM(String question) async {
    GeneralResponse resposne = await viewmodel.sendLLMmessage({
      "user_id": hiveUser.getUserId.toString(),
      "chat_session_id": SessionID.toString(),
      "role": "u",
      "content": question.toString(),
    });

    return resposne;

  }

  Future<dynamic> addChatSession() async {
    userBox = Hive.box<UserHiveModel>('userBox');
    hiveUser = await userBox.get("currentUser");

    if (messages.isEmpty || SessionID == -1) {
      GeneralResponse response = await viewmodel.addSessionID(
        hiveUser.getUserId,
      );

      if (response.code == 200) {
        SessionID = response.data[0]["id"];
        messages.clear();
        setState(() {});
      } else {
        mUtils.toastMessage("session could not be added.");
      }
    }
  }


  void showPremiumDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.workspace_premium,
                    size: 60, color: Colors.amber),

                const SizedBox(height: 16),

                const Text(
                  "Free Plan Ended",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Upgrade to Premium for unlimited messages and advanced AI features.",
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Close"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, RouteNames.UpgradeToPremiumScreen);
                        },
                        child: const Text("Upgrade"),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
