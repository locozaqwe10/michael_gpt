import 'package:custom_chat_gpt/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utilities/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 2200),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushNamed(context, RouteNames.SubSplashScreen);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () async {
        SystemNavigator.pop();
        return false;
        },
      child: Scaffold(
        body: FadeTransition(
          opacity: _opacityAnimation,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorPrimary, // dark-blue
                  ColorSecandory, // blue-purple
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Optional logo if available
                // Image.asset('assets/michael_gpt_logo.png', width: 120),
                Image.asset("assets/images/logo_nobg.png",
                width: 300,),
                SizedBox(height: 10),
                Text(
                  'Michael GPT',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Your AI Entrepreneur Sidekick',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
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
