import 'package:custom_chat_gpt/routes/routes_name.dart';
import 'package:custom_chat_gpt/utilities/colors.dart';
import 'package:custom_chat_gpt/widgets/chat_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../utilities/hive/user_hive_model.dart';
import '../../widgets/chat_bubble_message.dart';
import '../../widgets/circular_letter_avatar.dart';
import 'chat_list.dart';

class ChatScreen  extends StatefulWidget{
  const ChatScreen({super.key});

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
  bool hasValidPackage = true;

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
  /* print (hiveUser!.create_at);
   final now = DateTime.now();
   final difference = now.difference(hiveUser!.create_at!).inDays;
   if (subscriptionName == 'free' &&  difference > 14){
     hasValidPackage = false;
   }*/
   setState(() {

   });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorPrimary,
        actionsIconTheme:  IconThemeData(
          color: Colors.white
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Change drawer icon color here
        ),
        elevation: 0.5,
        title: const Text("MichaelGPT", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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
              currentAccountPicture:  hiveUser==null?circularAvatar(name:userName, radius: 50)
                  :hiveUser!.imageUrl!=""?ClipOval(child: Image.network(hiveUser!.imageUrl, height: 100, width: 100,fit: BoxFit.fill,)):circularAvatar(name:userName, radius: 50),
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
            ListTile(
              leading: const Icon(Icons.keyboard_double_arrow_right_rounded),
              title: const Text("How to use MichealGPT?"),
              onTap: () { Navigator.pushNamed(context, RouteNames.HowToUserMichealGPT);},
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

          ],
        ),
      ),
    );
  }
}

