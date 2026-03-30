

import 'package:custom_chat_gpt/model/useage_model.dart';
import 'package:custom_chat_gpt/utilities/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/usage_michealgpt.dart';

class AboutUsageScreen extends StatefulWidget {
  const AboutUsageScreen({super.key});

  @override
  State<StatefulWidget> createState () => _aboutUsage();


}

class _aboutUsage extends State{
  List<UsageGPTItem> usageItems = [
    UsageGPTItem(
      header: "Just prompt it — like ChatGPT",
      body: "Open it and ask your question. No special prompts. No framework language. No setup.",

    ),
    UsageGPTItem(
      header: "Applying the Survival System",
      body: "Michael GPT interprets your situation through the Survival System and applies the relevant weapon(s) automatically.",
    ),
    UsageGPTItem(
      header: "Prompt it with anything that comes up",
      body: "Any founder issue: what to focus on, what to change, and what to do next.",
    ),
  ];
  List<UsageGPTItem> HelpItems = [
    UsageGPTItem(
      header: "Applies the Survival System to real decisions",
      body: "Helps you apply the weapons and tactics to your business today.",

    ),
    UsageGPTItem(
      header: "Brings judgment and experience in real time",
      body: "Michael GPT interprets your situation through the Survival System and applies the relevant weapon(s) automatically.",
    ),
    UsageGPTItem(
      header: "Reduces learning by making mistakes",
      body: "So you don’t guess alone — you leverage AI and a seasoned founder’s experience.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
          
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your AI Sidekick",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 12
                          ),
                        ),
                        Text(
                            "MichealGPT",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        ),
          
          
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        border: BoxBorder.all(color: ColorPrimary, width: 3)
                      ),
                      child: ClipOval(

                        child: Image.asset("assets/images/micheal_dp.png", width: 50,
                          height: 50,
                          fit: BoxFit.cover,

                        ),
                      ),
                    )
                  ],
                ),
              ),
          
          

                   FAQWidget(items: usageItems, title: "How You Use Michael GPT",),
          SizedBox(height: 15,),

                  FAQWidget(items: HelpItems,title: "How Michael GPT Helps",),
            ],
          ),
        ),
      ),
    );
  }

}