import 'package:flutter/material.dart';

import '../../routes/routes_name.dart';
import '../../utilities/colors.dart';


class ChatHistoryScreen extends StatelessWidget {
  const ChatHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color:Colors.white ),
          onPressed: () {Navigator.pop(context);},
        ),
        title:  Text(
          "Chat History",
          style: TextStyle(color: Colors.white),
        ),

        centerTitle: true,
        actions: [

        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
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
                        Navigator.pushNamed(context, RouteNames.ChatScreen);
                        // TODO: handle account creation
                      },
                      child:Center(
                        child: const Text(
                          "Let's Start Chat with Michael GPT",

                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
