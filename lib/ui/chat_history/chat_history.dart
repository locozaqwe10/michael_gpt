import '../../data/chat_history_model.dart';
import '../../data/response/status.dart';
import '../../ui/chat_history/chat_history_viewmodel.dart';
import '../../utilities/APP_CODES.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../routes/routes_name.dart';
import '../../utilities/colors.dart';
import '../../utilities/hive/user_hive_model.dart';
import '../../widgets/chat_bubble_message.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChatHistoryScreen();
}

class _ChatHistoryScreen extends State {
  var viewmodel = ChatHistoryViewmodel();
  late Box userBox = Hive.box<UserHiveModel>('userBox');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    callHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: AlignmentGeometry.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CHAT HISTORY",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 6),

                    Text(
                      "Your talk with MichealGPT",
                      style: TextStyle(color: Colors.grey),
                    ),

                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            ChangeNotifierProvider<ChatHistoryViewmodel>(
              create: (BuildContext context) => viewmodel,
              child: Consumer<ChatHistoryViewmodel>(
                builder: (context, value, child) {
                  switch (value.apiChatHistoryNotify.status) {
                    case null:
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon circle
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: ColorPrimary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.chat_bubble_outline,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Title
                            const Text(
                              'No chat history yet',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Subtitle
                            Text(
                              'Start a new conversation to see it here',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Button
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                  colors: [ColorPrimary, Colors.purple],
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.ChatScreen,
                                    );
                                    // TODO: handle account creation
                                  },
                                  child: Center(
                                    child: const Text(
                                      "Let's Start Chat with Michael GPT",

                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    case Status.LOADING:
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: ColorPrimary),
                            Text(
                              "Please be patient, we are loading your talks with Michael GPT",
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    case Status.COMPLETE:
                      if (value.apiChatHistoryNotify.data != null &&
                          value.apiChatHistoryNotify.data!.length > 0) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          child: ListView.builder(
                            itemCount: value.apiChatHistoryNotify.data!.length,
                            itemBuilder: (context, index) {
                              if (value
                                      .apiChatHistoryNotify
                                      .data![index]
                                      .messages
                                      .length >
                                  0) {
                                return ExpansionTile(
                                  tilePadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  childrenPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  iconColor: ColorPrimary,
                                  collapsedIconColor: ColorPrimary,
                                  initiallyExpanded: false,

                                  title: Card(
                                    elevation: 1.5,
                                    margin: const EdgeInsets.symmetric(vertical: 2), // reduced space
                                    color: SubColorSecandory,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                      child: Text(
                                        value.apiChatHistoryNotify.data![index].messages[0].content ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: ColorPrimary,
                                        ),
                                      ),
                                    ),
                                  ),

                                  children: List.generate(
                                    value.apiChatHistoryNotify.data![index].messages.length,
                                        (i) {
                                      final message =
                                      value.apiChatHistoryNotify.data![index].messages[i]!.content!
                                          .replaceAll("{\"output\":", "")
                                          .replaceAll("}", "");

                                      final isBot =
                                          value.apiChatHistoryNotify.data![index].messages[i]!.role == "a";

                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 4), // reduced gap between bubbles
                                        child: ChatBubble(
                                          message: message,
                                          isMe: isBot ? AppCodes.CHAT_BOT : AppCodes.CHAT_USER,
                                          time: value.apiChatHistoryNotify.data![index].messages[i]!
                                              .createdAt!
                                              .toIso8601String(),
                                          firstName: "",
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return SizedBox(height: 0);
                              }
                            },
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Icon circle
                              Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: ColorPrimary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.chat_bubble_outline,
                                  size: 32,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Title
                              const Text(
                                'No chat history yet',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 8),

                              // Subtitle
                              Text(
                                'Start a new conversation to see it here',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),

                              const SizedBox(height: 32),

                              // Button
                              Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    colors: [ColorPrimary, Colors.purple],
                                  ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteNames.ChatScreen,
                                      );
                                      // TODO: handle account creation
                                    },
                                    child: Center(
                                      child: const Text(
                                        "Let's Start Chat with Michael GPT",

                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    case Status.ERROR:
                      print("error");
                      return Text("Something went wrong");
                  }
                  ;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> callHistoryData() async {
    UserHiveModel hiveUser = await userBox.get("currentUser");
    //userName = hiveUser!.getUserName;
    viewmodel.getChatHistory(hiveUser.getUserId);
  }
}
