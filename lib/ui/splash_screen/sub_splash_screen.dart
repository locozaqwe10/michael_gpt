import 'dart:convert';
import 'dart:io';

import 'package:custom_chat_gpt/routes/routes_name.dart';
import 'package:custom_chat_gpt/ui/splash_screen/spashscreen_viewmodel.dart';
import 'package:custom_chat_gpt/utilities/colors.dart';
import 'package:custom_chat_gpt/utilities/constants.dart';
import 'package:custom_chat_gpt/utilities/hive/user_hive_model.dart';
import 'package:custom_chat_gpt/utilities/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:hive/hive.dart';

/*class SubSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}*/

class SubSplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubSplashScreen();
}

class _SubSplashScreen extends State {
  bool isLightTheam = false;
  String assetsLogo = "assets/images/logo_white_text.png";

  var box = Hive.box<UserHiveModel>('userBox');
  var box2 = Hive.box<dynamic>('keybox');
  var viewModel = SplashScreenViewmodel();

  Future<void> _saveuser() async {
    /*final user = UserHiveModel(
      userId: "123",
      email: "test@mail.com",
      userName: "Nauman", subscriptionId: '', subscriptionInTokenAllowed: 0, subscriptionOutTokenAllowed: 0, userInToken: 0, userOutToken: 0,
    );
  await box.put('currentUser', user);*/

    if (box2.containsKey(Constants.STRIPE_PUBLISH_KEY)) {

    } else{
      var keyResponse = await viewModel.getAPIkey(Constants.STRIPE_PUBLISH_KEY);


    if (keyResponse.code == 200) {
      var keyData = keyResponse.data;
      List<dynamic> jsonArray = jsonDecode(keyData);
      jsonArray.map((value) async =>
      {
        if (value["key_name"] == Constants.STRIPE_PUBLISH_KEY){
          await box2.put(Constants.STRIPE_PUBLISH_KEY, (value["key_value"])),

        },});
      Stripe.publishableKey = box2.get(Constants.STRIPE_PUBLISH_KEY);
      await Stripe.instance.applySettings();
    } else {
      mUtils.toastMessage(keyResponse.message);
    }
  }

  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _saveuser());
  }

  @override
  Widget build(BuildContext context) {
    // Colors for the feature icons
    //final featureColors = [Colors.purple, Colors.blue, Colors.green];
    final featureColors = [Colors.white, Colors.white, Colors.white];

    // Feature data
    final features = [
      {
        'icon': Icons.flash_on,
        'title': 'Just Prompt it — like ChatGPT',
        'subtitle':
            'Open it and ask your question. No special prompts. No framework language. No setup.',
        'color': featureColors[0],
      },
      {
        'icon': Icons.chat_bubble_outline,
        'title': 'Applying the Survival System',
        'subtitle':
            'MichaelGPT interprets your situation through the Survival System and applies the relevant weapon(s) automatically.',
        'color': featureColors[1],
      },
      {
        'icon': Icons.shield_outlined,
        'title': 'Prompt it with Anything that Comes Up',
        'subtitle': 'Your conversations are secure and private',
        'color': featureColors[2],
      },
    ];

    if (isLightTheam) {
      assetsLogo = "assets/images/logo_nobg.png";
    } else {
      assetsLogo = "assets/images/logo_white_text.png";
    }

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop(); // closes the app
        return false;
      },
      child: Scaffold(
        backgroundColor: isLightTheam ? Colors.white : Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isLightTheam = !isLightTheam;
                    if (kDebugMode) {
                      print("the current theme is $isLightTheam");
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: Align(
                    alignment: Alignment.topRight,

                    child: Icon(
                      Icons.light_mode,
                      color: isLightTheam ? Colors.black : Colors.white,
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
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Center(child: Image.asset(assetsLogo, width: 300)),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            const Text(
                              'MichaelGPT',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorSecandory,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3,
                                shadows: [
                                  Shadow(
                                    offset: Offset(
                                      2.0,
                                      0.0,
                                    ), // position of shadow
                                    blurRadius: 2.0, // softness
                                    color: Colors.white, // shadow color
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'Your AI Sidekick',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorSecandory,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Built by ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ColorSecandory,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 3,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'Michael Dermer.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ColorSecandory,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 3,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(
                                          2.0,
                                          0.0,
                                        ), // position of shadow
                                        blurRadius: 1.0, // softness
                                        color: Colors.white, // shadow color
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,

                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5),

                    if (isLightTheam) ...[
                      Column(
                        children: [
                          SizedBox(height: 15),
                          Text(
                            'MichaelGPT',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: ColorPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: ColorPrimary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              'ChatGPT in your pocket — trained on Michael’s judgment and The Lonely Entrepreneur Survival System.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ] else ...[
                      // Title
                      Container(
                        decoration: BoxDecoration(
                          color: SubColorSecandory,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: BoxBorder.all(
                            width: 2,
                            color: ColorPrimary,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 15),
                            Text(
                              'MichaelGPT',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: ColorPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: EdgeInsets.only(left: 25, right: 25),
                              child: Text(
                                'ChatGPT in your pocket — trained on Michael’s judgment and The Lonely Entrepreneur Survival System.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                              ),
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
                              color: isLightTheam ? Colors.white : Colors.black,
                              elevation: isLightTheam ? 2 : 0,
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
                                    color: ColorPrimary,
                                  ),
                                ),
                                title: Text(
                                  feature['title'] as String,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: ColorPrimary,
                                  ),
                                ),
                                subtitle: Text(
                                  feature['subtitle'] as String,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isLightTheam
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
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
                                //
                                // TODO: handle account creation

                                var users = box.get('currentUser');
                                print(users?.getEmail);
                                if (users?.getEmail != null) {
                                  if (users!.getEmail.isNotEmpty) {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.ChatScreen,
                                    );
                                  } else {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.LoginScreen,
                                    );
                                  }
                                } else {
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.LoginScreen,
                                  );
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Start Using MichaelGPT",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: Text(
                            "Try it out to see how MichaelGPT applies the Survival System to real decisions.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isLightTheam ? ColorPrimary : Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
