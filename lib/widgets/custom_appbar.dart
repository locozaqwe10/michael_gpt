
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utilities/colors.dart';

class MichaelGPTAppBar extends StatelessWidget implements PreferredSizeWidget {
  ValueChanged<int> onTapNewChat;
   MichaelGPTAppBar({super.key, required this.onTapNewChat});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: SubColorSecandory,
      automaticallyImplyLeading: false,
      toolbarHeight: 100,
      elevation: 0,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 15),
        child: Row(

          children: [
            Stack(

              children: [
                Container(
                  padding: const EdgeInsets.all(2), // border thickness
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorPrimary,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage('assets/images/micheal_dp.png'), // your image

                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),

            // Title + subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "MICHAELGPT",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),

                      // AI Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.auto_awesome,
                                size: 12, color: Colors.orange),
                            SizedBox(width: 4),
                            Text(
                              "AI",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "Powered by Michael Dermer's wisdom",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

                  GestureDetector(
                    onTap: (){
                     onTapNewChat(3);
                    },
                    child: Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                    color:
                    ColorPrimary,

                    borderRadius: BorderRadius.circular(20),
                    ),
                    child:  Icon(
                    FontAwesomeIcons.plus,
                     color:Colors.white   ,
                    ),

                    ),
                  )],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}