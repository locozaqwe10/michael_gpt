import 'dart:io';

import 'package:custom_chat_gpt/routes/routes_name.dart';
import 'package:custom_chat_gpt/utilities/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



/*class SubSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}*/

class SubSplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _SubSplashScreen();
}

class _SubSplashScreen extends State {

  bool isLightTheam = false;
  String assetsLogo = "assets/images/logo_white_text.png";
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

    if (isLightTheam){

      assetsLogo = "assets/images/logo_nobg.png";
    }else {

      assetsLogo = "assets/images/logo_white_text.png";
    }
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop(); // closes the app
      return false;

      },
      child: Scaffold(
backgroundColor:  isLightTheam ? Colors.white : Colors.black,
        body: SafeArea(
          child: Stack(
            children:[
              InkWell(
                onTap: (){


                      setState(() {
                        isLightTheam = !isLightTheam;
                        if (kDebugMode) {
                          print("the current theme is $isLightTheam" );
                        }
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: Align(
                    alignment: Alignment.topRight,

                    child: Icon(
                       Icons.light_mode,
                      color:   isLightTheam ? Colors.black : Colors.white,

                    ),
                  ),
                ),
              ),
              Padding(

              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // App icon

                  SizedBox(height: 20,),
                  Column(
                    children: [
                      Center(
                        child: Image.asset(assetsLogo,
                          width: 300,),
                      ),
            SizedBox(height: 10,),
                      Text(
                        'The Lonely Entrepreneur is the solution for every entrepreneur. Outsources save your time, money and pain.',
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


                  if (isLightTheam)...[

                    Column(
                      children: [
                        SizedBox(height: 15),
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
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: ColorPrimary,
                            borderRadius: BorderRadius.all(Radius.circular(10))
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
                        SizedBox(height: 15),
                      ],
                    ),

                  ]else
                    ...[
                      // Title
                      Container(

                        decoration: BoxDecoration(
                            color: SubColorSecandory,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: BoxBorder.all(width: 2,
                              color: ColorPrimary,
                              style: BorderStyle.solid,
                            )
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 15),
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
                            Text(
                              'ChatGPT in your pocket — trained on Michael’s judgment and The Lonely Entrepreneur Survival System.',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w900
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),

                    ],
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
                            color:   isLightTheam ? Colors.white : Colors.black,
                            elevation:   isLightTheam ? 2 : 0,
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
                                  fontWeight: FontWeight.bold, color:   isLightTheam ? Colors.black : Colors.white,
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
                      Text("Try it out to see how Michael GPT applies the Survival System to real decisions.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, color:   isLightTheam ? ColorPrimary : Colors.white, fontSize: 15),),
                    ],
                  ),

                ],
              ),
            ),
         ], ),
        ),
      ),
    );
  }
}
