import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../model/chat_list_model.dart';
import '../../model/general_response.dart';
import '../../routes/routes_name.dart';
import '../../utilities/APP_CODES.dart';
import '../../utilities/colors.dart';
import '../../utilities/hive/user_hive_model.dart';
import '../../utilities/utils.dart';
import '../../widgets/ask_micheal_default_widget.dart';
import '../../widgets/chat_bubble_message.dart';
import '../../widgets/preload_chat_questions.dart';
import '../chat_screen/chat_screen_viewmodel.dart';

class ChatListNew extends StatefulWidget {
  int refreshs;

  ChatListNew(this.refreshs, {Key? key}): super(key: key);

  @override
  _ChatListNEW createState() => _ChatListNEW();
}

class _ChatListNEW extends State<ChatListNew> {
  final List<ChatMessage> messages = [];
  int SessionID = -1;
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  late Box userBox;
  ChatScreenViewmodel viewmodel = ChatScreenViewmodel();
  late UserHiveModel hiveUser;
  bool isWaitingResponse = false;
  int refresh = 0;
  bool hasValidPackage = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initHive();
    print("init");

      addChatSession();

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.black,
      child: Column(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (messages.length > 0) ...[
            Container(
              height: MediaQuery.of(context).size.height * 0.62,
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
                      firstName: hiveUser.getUserName,
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
          ] else ...[
            SizedBox(
              height:MediaQuery.of(context).size.height * 0.62,
              child: AskMichaelDefaultWidget((value) {
                _sendMessage(value);
              }),
            ),
          ],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,

    decoration: BoxDecoration(
    color: SubColorSecandory,
    shape: BoxShape.rectangle,

    border: BoxBorder.fromLTRB(top: BorderSide(color: Colors.white12,
      style: BorderStyle.solid,
      width: 1,))
    ),


              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0, bottom: 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,

                            decoration: BoxDecoration(
                              color: SubColorSecandory,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              border: BoxBorder.all(
                                color: Colors.white12,
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                controller: controller,
                                style: TextStyle(
                                  backgroundColor: SubColorSecandory,
                                  color: Colors.white,
                                ),
                                decoration: const InputDecoration(
                                  hintText: "Ask Michael...",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (value) {
                                  _sendMessage(controller.text.trim());
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(8),

                          decoration: BoxDecoration(
                            color: ColorPrimary,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: BoxBorder.all(
                              color: Colors.white70,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.send),
                            color: Colors.white70,
                            onPressed: () {
                              _sendMessage(controller.text.trim());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage(String question) async {
    if (question.isEmpty) return;
    if (!hasValidPackage) {
      showPremiumDialog(context);
    }

    controller.clear();

    setState(() {
      messages.add(
        ChatMessage(
          message: question,
          isMe: AppCodes.CHAT_USER,
          time: DateTime.now(),
          errorMessage: '',
        ),
      );
      isWaitingResponse = true;
    });

    _scrollToBottom();

    //  CALL YOUR LLM API HERE
    final response = await callLLM(question);

    if (response.code == 200) {
      setState(() {
        String data = response.data["llm_response"].toString().isEmpty
            ? ""
            : jsonDecode(response.data["llm_response"])["output"];
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

      //  _scrollToBottom();
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
      setState(() {});
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

  Future<dynamic>  initHive() async {}


  Future<dynamic> addChatSession() async {
    userBox = Hive.box<UserHiveModel>('userBox');
    hiveUser = await userBox.get("currentUser");
    if (refresh == AppCodes.REFRESH ) {
      messages.clear();
    }
    if (refresh == AppCodes.REFRESH && (messages.isEmpty || SessionID == -1) ){
      GeneralResponse response = await viewmodel.addSessionID(
        hiveUser.getUserId,
      );

      if (response.code == 200) {
        SessionID = response.data[0]["id"];
        messages.clear();
        if (!mounted) return;
        setState(() {});
      } else {
        mUtils.toastMessage("session could not be added.");
      }
    }
  }

  Future<void> checkPackageValidity() async {
    //hiveUser = await userBox.get("currentUser");

    String subscriptionName = hiveUser!.getSubscriptionFriendlyName;
    print(hiveUser!.create_at);
    final now = DateTime.now();
    final difference = now.difference(hiveUser!.create_at!).inDays;
    if (subscriptionName == 'free' && difference > 14) {
      hasValidPackage = false;
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
                const Icon(
                  Icons.workspace_premium,
                  size: 60,
                  color: Colors.amber,
                ),

                const SizedBox(height: 16),

                const Text(
                  "Free Plan Ended",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                          Navigator.pushNamed(
                            context,
                            RouteNames.UpgradeToPremiumScreen,
                          );
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

  Widget questionButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}
