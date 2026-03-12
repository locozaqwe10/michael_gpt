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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Chat History", style: TextStyle(color: Colors.white)),

        centerTitle: true,
        actions: [],
      ),
      body: SafeArea(
        child: ChangeNotifierProvider<ChatHistoryViewmodel>(
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
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      CircularProgressIndicator(color: ColorPrimary),
                      Text(
                        "Please be patient, we are loading your talks with Michael GPT",
                      ),
                    ],
                  );
                case Status.COMPLETE:
                  if (value.apiChatHistoryNotify.data != null &&
                      value.apiChatHistoryNotify.data!.length > 0) {
                    return Container(
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
                              tilePadding: EdgeInsets.all(8),
                              childrenPadding: EdgeInsets.all(8),
                              title: Card(
                                elevation: 3,

                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    value
                                        .apiChatHistoryNotify
                                        .data![index]
                                        .messages[0]
                                        .content!,
                                    style: TextStyle(
                                      fontSize: 12,

                                    ),
                                  ),
                                ),
                              ),
                              initiallyExpanded: false,

                              children: [
                                for (int i=0; i< value
                                    .apiChatHistoryNotify
                                    .data![index]
                                    .messages.length; i++)...[
                                  ChatBubble(
                                    message: value
                                      .apiChatHistoryNotify
                                      .data![index]
                                      .messages[i]!.content!.replaceAll("{\"output\":", "").replaceAll("}", ""), isMe: value
                                      .apiChatHistoryNotify
                                      .data![index]
                                      .messages[i]!.role=="a"?AppCodes.CHAT_BOT:AppCodes.CHAT_USER, time: value
                                      .apiChatHistoryNotify
                                      .data![index]
                                      .messages[i]!.createdAt!.toIso8601String(), firstName: "",
                                  ),
                                ]
                              ]);

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
      ),
    );
  }

  Future<void> callHistoryData() async {
    UserHiveModel hiveUser = await userBox.get("currentUser");
    //userName = hiveUser!.getUserName;
    viewmodel.getChatHistory(hiveUser.getUserId);
  }
}
