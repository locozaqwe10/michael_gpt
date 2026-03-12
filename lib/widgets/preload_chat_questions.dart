import 'package:flutter/material.dart';

class AskMichaelScreen extends StatelessWidget {
  final ValueChanged<String> onQuestionTap;
   AskMichaelScreen( this.onQuestionTap, {super.key});

  Widget questionButton(String text, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.orange,
                width: 3,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// LOGO
                ClipOval(child: Container(

                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/tle_logo_black_bg.png",
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,),
                  ),
                )),

                const SizedBox(height: 16),

                /// TITLE
                const Text(
                  "Ask Michael. Your Sidekick at Every Step.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                /// AUTHOR
                Text(
                  "By Michael Dermer",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 14),

                /// DESCRIPTION
                const Text(
                  "Michael is your Sidekick. Whenever. Wherever. "
                      "He lived thru a crisis. Invented an industry "
                      "(health rewards). Had an exit. Now he has created "
                      "the Entrepreneur Survival Guide — the 6 Weapons you "
                      "need to survive and thrive in a world of AI.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 16),

                const Divider(),

                const SizedBox(height: 16),

                /// QUESTIONS GRID
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.5,
                  physics: const NeverScrollableScrollPhysics(),

                  children: [
                    questionButton(
                        "What are the Six Weapons I need in an AI World?",
                          () {
                                    onQuestionTap("What are the Six Weapons I need in an AI World?");
                        },),
                    questionButton(
                        "Do you have AI prompts tied to these weapons?",
                          () {
                                onQuestionTap( "Do you have AI prompts tied to these weapons?");
                        },),
                    questionButton(
                        "What is Michael Dermer's story? Is he that extreme?",
                          () {
onQuestionTap("What is Michael Dermer's story? Is he that extreme?");
                        },),
                    questionButton(
                        "What are all the things Michael helps with?",
                          () {
                onQuestionTap( "What are all the things Michael helps with?");
                        },),
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