
import 'package:customchatgpt/utilities/APP_CODES.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../routes/routes_name.dart';
import '../../utilities/colors.dart';
import '../../utilities/hive/user_hive_model.dart';
import '../../widgets/circular_letter_avatar.dart';
import '../../widgets/custom_appbar.dart';
import 'chat_list_new.dart';

class ChatScreenNew extends StatefulWidget {
  const ChatScreenNew({super.key});

  @override
  State<StatefulWidget> createState() => _ChatScreenNew();
}

class _ChatScreenNew extends State {
  UserHiveModel? hiveUser;
  bool _isLoading = false;
  String userName = "";
  String subscription = "";
  String subscriptionName = "";
  late Box userBox;
  int refresh = 0;
  bool hasValidPackage = true;
  Key _homeKey = UniqueKey();
  @override
  initState() {
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

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor:SubColorSecandory,
      appBar: MichaelGPTAppBar(onTapNewChat: (int value) {
       // refresh = refresh+1;
      //  print("refresh " +value.toString());
        setState(() {
          _homeKey = UniqueKey(); // 🔥 new key = new widget
          refresh = AppCodes.REFRESH;
        });
        refresh = -1;
      },),

      body: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [ChatListNew( refresh, key: _homeKey,)]),

      ),
    );
  }
}
