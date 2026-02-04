import 'package:custom_chat_gpt/routes/routes_name.dart';
import 'package:custom_chat_gpt/ui/chat_screen/chat_sreen.dart';
import 'package:custom_chat_gpt/ui/login_screen/login_screen.dart';
import 'package:custom_chat_gpt/ui/profile_screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/chat_history/chat_history.dart';
import '../ui/create_account_screen/CreateAccountScreen.dart';
import '../ui/splash_screen/splash_screen.dart';
import '../ui/splash_screen/sub_splash_screen.dart' hide SplashScreen;
import '../ui/subscription/subscription_congrats_screen.dart';
import '../ui/subscription/upgrade_to_premium_options/UpgradeToPremiumScreen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case RouteNames.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen(),
            settings: settings);
      case RouteNames.SubSplashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => SubSplashScreen(),
            settings: settings);
      case RouteNames.LoginScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen(),
            settings: settings);
      case RouteNames.CreateAccountScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => CreateAccountScreen(),
            settings: settings);
      case RouteNames.ChatScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => ChatScreen(),
            settings: settings);
      case RouteNames.ProfileScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => ProfileScreen(),
            settings: settings);
      case RouteNames.ChatHistoryScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => ChatHistoryScreen(),
            settings: settings);
        case RouteNames.UpgradeToPremiumScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => UpgradeToPremiumScreen(),
            settings: settings);
     case RouteNames.PremiumSuccessScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => PremiumSuccessScreen(),
            settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) {
              return Scaffold(
                body: Center(
                  child: Text("No route defined."),
                ),
              );
            },
            settings: settings);
    }}}