
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

import '../../routes/routes_name.dart';
import '../../utilities/colors.dart';
import '../../utilities/hive/user_hive_model.dart';
import '../../widgets/circular_letter_avatar.dart';

class HomeFragment extends StatefulWidget{
  const HomeFragment({super.key});

  @override
  State<StatefulWidget> createState() =>_HomeFragment();

}

class _HomeFragment extends State<HomeFragment> {
  UserHiveModel? hiveUser ;
  late Box userBox;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userBox = Hive.box<UserHiveModel>('userBox');
    hiveUser = userBox.get("currentUser");
setState(() {

});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return WillPopScope(
     onWillPop: () async {
       SystemNavigator.pop(); // closes the app
       return false; // prevent default pop
     },
     child: Scaffold(
       extendBody: true,
       backgroundColor: Colors.black,
       appBar: AppBar(
         title: const Text("The Lonely Entrepreneur", style: TextStyle(color: ColorPrimary,letterSpacing: 1.5),),
         backgroundColor: Colors.black,
         automaticallyImplyLeading: false,
         iconTheme: const IconThemeData(
           color: ColorPrimary
         ),
         actions: [
           Container(

             decoration: BoxDecoration(
               shape: BoxShape.circle,
               border: BoxBorder.all(width: 3, color: ColorPrimary),

             ),
          child:  hiveUser==null?circularAvatar(name:"U", radius: 45)
               :hiveUser!.imageUrl!=""?ClipOval(child: Image.network(hiveUser!.imageUrl, height: 50, width: 50,fit: BoxFit.fill,)):circularAvatar(name:hiveUser!.userName, radius: 35),

           ),
           const SizedBox(width: 10)
         ],
       ),
       body: SingleChildScrollView(
         padding: const EdgeInsets.all(16),
         child: Padding(
           padding: const EdgeInsets.only(bottom: 110),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               /// HERO CARD
               Container(
                 padding: const EdgeInsets.all(20),
                 decoration: BoxDecoration(
                   color: Colors.grey[900],
                   borderRadius: BorderRadius.circular(20),
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Container(
                       padding:
                       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                       decoration: BoxDecoration(
                         border: Border.all(color: ColorPrimary),
                         borderRadius: BorderRadius.circular(20),
                       ),
                       child: const Text(
                         "NO ONE SHOULD DO IT ALONE",
                         style: TextStyle(color: ColorPrimary, fontSize: 12),
                       ),
                     ),
                     const SizedBox(height: 20),

                     const Text(
                       "WE ARE ALL",
                       style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                     ),
                     const Text(
                       "LONELY ENTREPRENEUR",
                       style: TextStyle(
                         fontSize: 30,
                         fontWeight: FontWeight.bold,
                         color: ColorPrimary,
                       ),
                     ),

                     const SizedBox(height: 10),

                     const Text(
                       "Your sidekick at every step. Built for founders who refuse to fail.",
                       style: TextStyle(color: Colors.grey),
                     ),

                     const SizedBox(height: 20),

                     GestureDetector(
                       onTap: (){
                         Navigator.pushNamed(context, RouteNames.HowToUserMichealGPT);
                       },
                       child: Container(
                         width: double.infinity,
                         padding: const EdgeInsets.symmetric(vertical: 14),
                         decoration: BoxDecoration(
                           color: ColorPrimary,
                           borderRadius: BorderRadius.circular(12),
                         ),
                         child: const Center(
                           child: Text(
                             "HOW TO USE MICHEALGPT? →",
                             style: TextStyle(
                                 color: Colors.black,
                                 fontWeight: FontWeight.bold),
                           ),
                         ),
                       ),
                     )
                   ],
                 ),
               ),

               const SizedBox(height: 20),

               /// STATS ROW
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   _statCard("57%", "Tasks AI can replace"),
                   _statCard("6", "Survival Weapons"),
                   _statCard("30", "Proven \nTactics"),
                   _statCard("1", "Unified \nSystem"),
                 ],
               ),

               const SizedBox(height: 30),

               Container(
                 padding: const EdgeInsets.all(10),
                 decoration: BoxDecoration(
                   color: ColorPrimary.withOpacity(0.3),
                   borderRadius: BorderRadius.circular(20),
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,

                   children: [

                     const SizedBox(height: 20),

                     const Text(
                       "MOST FOUNDERS WON'T SURVIVE AI.",
                       style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                     ),
                     const Text(
                       "WILL YOU?",
                       style: TextStyle(
                         fontSize: 30,
                         fontWeight: FontWeight.bold,
                         color: ColorPrimary,
                       ),
                     ),

                     const SizedBox(height: 10),

                     const Text(
                       "According to McKinsey, 57% of what founders do can be replaced by AI.",
                       style: TextStyle(color: Colors.grey),
                     ),




                   ],
                 ),
               ),
               const SizedBox(height: 20),
               _bookContainer(),

               const SizedBox(height: 20),

               /// SECTION TITLE
               const Text(
                 "THE 6 WEAPONS",
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 18,
                   fontWeight: FontWeight.bold,
                 ),
               ),

               const SizedBox(height: 16),

               /// ITEM 1
               weaponItem(
                 index: "#1",
                 title: "FINDING YOUR PLAYGROUND",
                 subtitle:
                 "If you're differentiating A and B, you've already lost.",
                 icon: Icons.rocket_launch,
                 color: ColorPrimary,
               ),

               const SizedBox(height: 12),

               /// ITEM 2
               weaponItem(
                 index: "#2",
                 title: "BRAND CHEMISTRY",
                 subtitle:
                 "In a world of machines, chemistry is the only human advantage.",
                 icon: Icons.favorite,
                 color: ColorPrimary,
               ),
               const SizedBox(height: 12),
               /// ITEM 3
               weaponItem(
                 index: "#3",
                 title: "Obsession",
                 subtitle:
                 "Obsession isn't optional — but it must be operationalized.",
                 icon: Icons.flash_on,
                 color: ColorPrimary,
               ),

               const SizedBox(height: 12),

               /// ITEM 4
               weaponItem(
                 index: "#4",
                 title: "Resilience",
                 subtitle:
                 "You will get punched in the face. The resilient stop noticing.",
                 icon: Icons.shield,
                 color: ColorPrimary,
               ),
               const SizedBox(height: 12),
               /// ITEM 5
               weaponItem(
                 index: "#5",
                 title: "Stretch Your Limits",
                 subtitle:
                 "If you don't stretch, your ceiling becomes your coffin.",
                 icon:  FontAwesomeIcons.superpowers,
                 color: ColorPrimary,
               ),

               const SizedBox(height: 12),

               /// ITEM 6
               weaponItem(
                 index: "#6",
                 title: "A.I",
                 subtitle:
                 "Apply AI to your goals — or it will be used against you.",
                 icon: FontAwesomeIcons.robot,
                 color:ColorPrimary,
               ),
               const SizedBox(height: 20),
             ],
           ),
         ),
       ),
     ),
   );
  }

  Widget _statCard(String number, String label) {
    return Expanded(
      child: Container(
        height: 80,
        width: 80,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          border: BoxBorder.all(
            width: 1,
            color: Colors.white70!.withOpacity(0.5),
          )
        ),
        child: Column(
          children: [
            Text(
              number,
              style: const TextStyle(
                  color: ColorPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  Widget _bookContainer (){
    return    Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          /// BOOK IMAGE
          Container(
            width: 80,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),

            ),
            child:  Image.asset("assets/images/book_cover.png"),
          ),

          const SizedBox(width: 16),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// STARS
                Row(
                  children: List.generate(
                    5,
                        (index) => const Icon(Icons.star,
                        color: ColorPrimary, size: 16),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "6 WEAPONS. 30 TACTICS.\nONE SYSTEM.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Available in digital, audio, and print.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 12),

                /// BUTTON
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 5),
                  decoration: BoxDecoration(
                    color: ColorPrimary,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "GET IT NOW",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward,
                          color: Colors.white, size: 16),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget weaponItem({
    required String index,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          /// ICON
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 12),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      index,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const Icon(Icons.chevron_right, color: Colors.grey)
        ],
      ),
    );
  }
}