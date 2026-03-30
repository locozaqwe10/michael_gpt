
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../routes/routes_name.dart';
import '../../utilities/colors.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int selectedIndex = 0;



  final List<Map<String, String>> resources = [
    {
      "title": "How to Operationalize Obsession?",
      "desc": "Turn your passion into a systematic advantage that compounds over time.",
      "category": "Mindset",
  "icon": FontAwesomeIcons.alignJustify.toString()
    },
    {
      "title": "57% of Your Work Will Be Replaced",
      "desc": "The McKinsey report founders must understand to survive in an AI world.",
      "category": "A.I"
    },
    {
      "title": "Brand Chemistry Over Features",
      "desc": "Why chemistry and human connection beat product specs every time.",
      "category": "Podcast"
    },
    {
      "title": "Resilience: Stop Noticing the Punches",
      "desc": "Real resilience isn't about bouncing back — it's about not feeling it anymore.",
      "category": "Video"
    },
  ];

  late final List<String> categories = [
    "All",
    ...resources.map((item) => item["category"]!).toSet(),
  ];

  List<Map<String, String>> get filteredList {
    if (selectedIndex == 0) return resources;

    return resources
        .where((item) =>
    item["category"] == categories[selectedIndex])
        .toList();
  }
@override
  void initState() {

    super.initState();

 //   categories + resources.map((item) => item["category"]!).toSet().toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TITLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "EXPLORE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),

                      Text(
                        "Resources to survive & thrive.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, RouteNames.ChatHistoryScreen);
                    }
                    ,
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
                        FontAwesomeIcons.history,
                        color:Colors.white   ,
                      ),

                    ),
                  ),
                ],
              ),


              SizedBox(height: 10),

              /// SEARCH
             /* Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.grey),
                    hintText: "Search resources...",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),*/

              SizedBox(height: 16),
              /// FEATURED CARD
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ColorPrimary, Colors.orange],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orange, Colors.orange],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text("FEATURED",
                          style: TextStyle(color: Colors.white70,fontSize: 12)),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "THE ENTREPRENEUR\nSURVIVAL SYSTEM",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "6 weapons · 30 tactics",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              /// HORIZONTAL CATEGORY LIST
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorPrimary
                              : Colors.grey[900],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 10),



              /// LIST
              Expanded(
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final item = filteredList[index];

                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: exploreListItem(item['title']!, item['desc']!, "", FontAwesomeIcons.fireFlameCurved)
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget exploreListItem (String title , String desc, String link, IconData icon){
   return InkWell(
     onTap: () async {
       final Uri url = Uri.parse('https://blog.lonelyentrepreneur.com/');

       if (!await launchUrl(
       url,
       mode: LaunchMode.externalApplication,
       )) {
       throw 'Could not launch $url';
       }


     },
     child: SizedBox(


       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icon,
                color: ColorPrimary),

            SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                   desc,
                    style: TextStyle(
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
       SizedBox(width: 10,),
            Text(
              "READ >",
              style: TextStyle(color: ColorPrimary),
            )
          ],
        ),
     ),
   );
  }
}