import 'package:custom_chat_gpt/model/useage_model.dart';
import 'package:custom_chat_gpt/ui/chat_screen/chat_list.dart';
import 'package:custom_chat_gpt/ui/chat_screen/chat_sreen.dart';
import 'package:custom_chat_gpt/ui/home_screen/home_fragment.dart';
import 'package:custom_chat_gpt/ui/profile_screen/profile_screen.dart';
import 'package:custom_chat_gpt/ui/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../utilities/colors.dart';
import '../about_usage_mgpt/about_usage.dart';
import '../chat_screen_new/chat_screen_new.dart';
import '../eplore_screen/explore_screen.dart';
import '../subscription/upgrade_to_premium_options/UpgradeToPremiumScreen.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});


  @override
  State<StatefulWidget> createState() => _homeScreen();
}

class _homeScreen extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = const [

   HomeFragment(),
    ExploreScreen(),
    ChatScreenNew(),
    ProfileScreen(),

  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _screens,
      ),

      bottomNavigationBar: Container(

        height: MediaQuery.of(context).size.height *0.122,
        margin: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 25),


        decoration: BoxDecoration(
          color: newSubColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white12),

        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
          backgroundColor: Colors.transparent,
          elevation: 5,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,



          items: [
            BottomNavigationBarItem(
              icon:  _bottomsheetIcon(Icons.home_outlined, 0, "Home"),
              label: '',

            ),
            BottomNavigationBarItem(
              icon: _bottomsheetIcon(Icons.explore_outlined, 1, 'Explore'),
              label: "",
            ),
            BottomNavigationBarItem(
              icon:  _bottomsheetIcon(Icons.chat_bubble_outline, 2, "MichealGPT"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon:  _bottomsheetIcon(Icons.person_outline, 3, "Profile"),
              label: "",
            ),

          ],
        ),
      ),
    );


  }
  Widget _bottomsheetIcon(IconData  icon, int index, String label) {
    return Container(
      height: 70,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(

              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? ColorPrimary.withOpacity(0.2)
                    : SubColorSecandory,
                borderRadius: BorderRadius.circular(20),
              ),
              child:  Icon(

                icon, color: _currentIndex == index
                  ? ColorPrimary.withOpacity(0.5)
                  : Colors.white70, size: 30,weight:0.01,)),

          Text(label, style: TextStyle(color:  _currentIndex == index
              ? ColorPrimary.withOpacity(0.5)
              : Colors.white70,fontSize: 10),)
        ],
      ),
    );

  }
}