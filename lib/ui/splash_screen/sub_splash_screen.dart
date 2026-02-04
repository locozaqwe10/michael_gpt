import 'dart:io';

import 'package:custom_chat_gpt/routes/routes_name.dart';
import 'package:custom_chat_gpt/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class SubSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Colors for the feature icons
    final featureColors = [Colors.purple, Colors.blue, Colors.green];

    // Feature data
    final features = [
      {
        'icon': Icons.flash_on,
        'title': 'Just Prompt it — like ChatGPT',
        'subtitle': 'Open it and ask your question. No special prompts. No framework language. No setup.',
        'color': featureColors[0]
      },
      {
        'icon': Icons.chat_bubble_outline,
        'title': 'Applying the Survival System',
        'subtitle': 'Michael GPT interprets your situation through the Survival System and applies the relevant weapon(s) automatically.',
        'color': featureColors[1]
      },
      {
        'icon': Icons.shield_outlined,
        'title': 'Prompt it with Anything that Comes Up',
        'subtitle': 'Your conversations are secure and private',
        'color': featureColors[2]
      },
    ];

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop(); // closes the app
      return false;

      },
      child: Scaffold(

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // App icon

                SizedBox(height: 20,),
                Column(
                  children: [
                    Center(
                      child: Image.asset("assets/images/logo_nobg.png",
                        width: 300,),
                    ),
SizedBox(height: 10,),
                    Text(
                      'The Lonely Entrepreneure is the solution for every entrepreneur. Ourresrouces save your time, money and pain.',
                      style: TextStyle(
                          fontSize: 16,
                          color: ColorSecandory,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 5),

                // Title
                Column(
                  children: [
                    Text(
                      'Michael GPT',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: ColorPrimary
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin:  EdgeInsets.all(2),
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: BoxBorder.all(color:  ColorPrimary,width: 5),
                          color: ColorPrimary
                      ),
                      child: Text(
                        'ChatGPT in your pocket — trained on Michael’s judgment and The Lonely Entrepreneur Survival System.',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w900
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  ],
                ),



                // Subtitle

                SizedBox(height: 10),

                // Features
                SizedBox(
            height: 300,

                  child: Center(
                    child: ListView.separated(
                      itemCount: features.length,
                      separatorBuilder: (_, __) => SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final feature = features[index];
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                color: feature['color'] as Color,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                feature['icon'] as IconData,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              feature['title'] as String,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color:ColorPrimary
                              ),
                            ),
                            subtitle: Text(feature['subtitle'] as String , style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Column(

                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [ColorPrimary, ColorSecandory],
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.pushNamed(context, RouteNames.LoginScreen);
                            // TODO: handle account creation
                          },
                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Start Using Michael GPT", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 18),),
                             SizedBox(width: 10,),
                              Icon(Icons.arrow_forward,color: Colors.white, size:30 ,fontWeight: FontWeight.bold,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text("Try it out to see how Michael GPT applies the Survival System to real decisions.",textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: ColorPrimary, fontSize: 15),),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
