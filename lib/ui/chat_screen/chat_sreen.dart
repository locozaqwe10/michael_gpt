import '../../routes/routes_name.dart';
import '../../utilities/colors.dart';
import '../../widgets/chat_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../utilities/hive/user_hive_model.dart';
import '../../widgets/chat_bubble_message.dart';
import '../../widgets/circular_letter_avatar.dart';
import 'chat_list.dart';

class ChatScreen  extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ChatScreen();
}

class _ChatScreen extends State {

  UserHiveModel? hiveUser ;
  bool _isLoading =false;
  String userName = "";
  String subscription = "";
  String subscriptionName = "";
  late Box userBox;
  int refresh = 0;

  @override
  initState()  {
    // TODO: implement initState
    super.initState();
    userBox = Hive.box<UserHiveModel>('userBox');
    populateValues();



  }
 populateValues() async {
   hiveUser = await userBox.get("currentUser");
   userName = hiveUser!.getUserName;
   subscriptionName = hiveUser!.getSubscriptionFriendlyName;
   setState(() {

   });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              currentAccountPicture:   circularAvatar(name:userName),
              accountName:  Text(userName +"-", style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail:  Text(subscriptionName),
            ),

            ListTile(
              leading: const Icon(Icons.chat_bubble_outline),
              title: const Text("New Chat"),
              onTap: () { Navigator.pushReplacementNamed(context,RouteNames.ChatScreen);},
            ),

            ListTile(
              leading: const Icon(Icons.history),
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
              onTap: () {

                Box   userBox = Hive.box<UserHiveModel>('userBox');
                userBox.clear();
                Navigator.pushNamedAndRemoveUntil(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
        
        
        
            ChatList( refresh),
            // --- INPUT FIELD ---
          /*  Container(
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
            ),*/
          ],
        ),
      ),
    );
  }
}

