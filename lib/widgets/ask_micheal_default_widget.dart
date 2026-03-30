import 'package:custom_chat_gpt/utilities/colors.dart';
import 'package:flutter/material.dart';

class AskMichaelDefaultWidget extends StatelessWidget {
  final ValueChanged<String> onQuestionTap;

  AskMichaelDefaultWidget(this.onQuestionTap, {super.key});
  final List<String> defaultQuestions = [
  "What are the Six Weapons I need in an AI World?",
  "Do you have AI prompts tied to these weapons?",
  "What is Michael Dermer's story? Is he that extreme?",
  "What are all the things Michael helps with?",];


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
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(

          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),

                  /// DESCRIPTION
                  RichText(
                    text: TextSpan(
                      text: "Hey, I'm ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "MichaelGPT",
                          style: TextStyle(
                            color: ColorPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 1,
                          ),
                        ),
                        TextSpan(
                          text:
                              "— crafted from the wisdom and experience of Michael Dermer, founder of The Lonely Entrepreneur.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            letterSpacing: 1,
                            height: 1.25,
                          ),
                        ),
                        TextSpan(
                          text:
                              "\n\n\nI'm here to be your sidekick at every step. Ask me anything about building your business, surviving the AI revolution, or just navigating the lonely road of entrepreneurship.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            letterSpacing: 1,
                            height: 1.25,
                          ),
                        ),
                        TextSpan(
                          text: "\n\n\nNo one should do it alone. ",
                          style: TextStyle(
                            color: ColorPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 1,
                            height: 1.25,
                          ),
                        ),
                        TextSpan(
                          text: "Let's go. 🔥",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            letterSpacing: 1,
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                  ),




                  const SizedBox(height: 16),

                  /// QUESTIONS GRID
              /*    GridView.count(
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
                          onQuestionTap(
                            "What are the Six Weapons I need in an AI World?",
                          );
                        },
                      ),
                      questionButton(
                        "Do you have AI prompts tied to these weapons?",
                        () {
                          onQuestionTap(
                            "Do you have AI prompts tied to these weapons?",
                          );
                        },
                      ),
                      questionButton(
                        "What is Michael Dermer's story? Is he that extreme?",
                        () {
                          onQuestionTap(
                            "What is Michael Dermer's story? Is he that extreme?",
                          );
                        },
                      ),
                      questionButton(
                        "What are all the things Michael helps with?",
                        () {
                          onQuestionTap(
                            "What are all the things Michael helps with?",
                          );
                        },
                      ),
                    ],
                  ),*/
                ],
              ),
            ),

            Expanded(
              child: Center(
                child: Container(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: defaultQuestions.length,
                    itemBuilder: (context, index) {


                      return GestureDetector(
                        onTap: () {
                            onQuestionTap( defaultQuestions[index]);
                        },

                        child: Container(
                          width: MediaQuery.of(context).size.width/2.2,
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color:  Colors.grey[900],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              defaultQuestions[index],
                              style: TextStyle(
                                color:  Colors.white70,
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
