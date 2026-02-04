import 'package:custom_chat_gpt/routes/routes_name.dart';
import 'package:custom_chat_gpt/utilities/colors.dart';
import 'package:custom_chat_gpt/widgets/chat_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: ColorPrimary,
        actionsIconTheme:  IconThemeData(
          color: Colors.white
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Change drawer icon color here
        ),
        elevation: 0.5,
        title: const Text("Michael GPT", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        actions: [
          /*Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=alex'),
            ),
          ),*/
        ],
      ),
      // --- NAVIGATION DRAWER ---
      drawer: Drawer(

        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: ColorPrimary),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=me'),
              ),
              accountName: const Text("Your Name", style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: const Text("Premium Member"),
            ),

            ListTile(
              leading: const Icon(Icons.chat_bubble_outline),
              title: const Text("Chat History"),
              onTap: () { Navigator.pushNamed(context, RouteNames.ChatHistoryScreen);},
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text("Profile"),
              onTap: () { Navigator.pushNamed(context, RouteNames.ProfileScreen);},
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text("Become Premium Member"),
              onTap: () { Navigator.pushNamed(context, RouteNames.UpgradeToPremiumScreen);},
            ),
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text("Logout", style: TextStyle(color: Colors.redAccent)),
              onTap: () {Navigator.pushNamedAndRemoveUntil(
                context,
                RouteNames.LoginScreen, // Replace with your actual route name
                    (Route<dynamic> route) => false,
              );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      // --- CHAT INTERFACE ---
      body: Column(
        children: [



          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                ChatBubble(
                  message: "How do I differentiate my business?",
                  isMe: false,
                  time: "10:18 AM",
                ),
                ChatBubble(
                  message: "You need to find your own playground where no one else is playing. Please tell me more about your business (ideas) and we can discuss further.",
                  isMe: true,
                  time: "10:19 AM",
                ),
                Visibility(
                  visible: false,

                  child: ChatBubble(
                    message: "Almost there!",
                    isMe: true,
                    time: "10:20 AM",
                  ),
                ),
              ],
            ),
          ),
          // --- INPUT FIELD ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: TextStyle(
                          color: SubColorSecandory,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: ColorPrimary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 20),
                      onPressed: () {},
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
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;

  const ChatBubble({super.key, required this.message, required this.isMe, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
            decoration: BoxDecoration(
              color: isMe ?  Color(0xFF007AFF) :  ColorPrimary,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isMe ? 16 : 0),
                bottomRight: Radius.circular(isMe ? 0 : 16),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.white,
                fontSize: 15,
              ),
            ),
          ),
          Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}