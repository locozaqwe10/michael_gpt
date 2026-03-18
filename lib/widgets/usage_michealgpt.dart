import 'package:custom_chat_gpt/model/useage_model.dart';
import 'package:custom_chat_gpt/utilities/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FAQWidget extends StatefulWidget {
  final List<UsageGPTItem> items; // <-- add this
  final String title;

  FAQWidget({required this.items, required this.title});

  @override
  _FAQWidgetState createState() => _FAQWidgetState();
}

class _FAQWidgetState extends State<FAQWidget> {
  late var items = widget.items;
  bool isExpended = false;
  List<ExpansibleController> controllers = [];

  @override
  void initState() {

    super.initState();
    controllers = List.generate(items.length, (_) => ExpansibleController());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepOrangeAccent),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10,right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [ColorPrimary, ColorSecandory],
                      ),
                    ),
                    child: InkWell(
                      child: Center(
                        child: Text(
                          isExpended?"Collapse all":"Expand all",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      onTap: () {

                        if (isExpended== false) {
                          for (var c in controllers) {
                            c.expand();
                          }
                          isExpended = true;
                        }else {
                          for (var c in controllers) {
                            c.collapse();
                          }
                          isExpended = false;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              child: Column(
                children: items.asMap().entries.map((entry) {
                  var item = entry.value;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(20),
                      border: item.isExpanded? BoxBorder.all(color: ColorPrimary): BoxBorder.all(color: Colors.transparent)
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        controller: controllers[entry.key],
                        iconColor: ColorPrimary,
                        collapsedIconColor: ColorPrimary,
                        splashColor: Colors.transparent,
                        initiallyExpanded: item.isExpanded,
                        onExpansionChanged: (value) {
                          setState(() {
                            item.isExpanded = value;

                          });
                        },
                        title: Text(
                          item.header,
                          style: const TextStyle(
                            color: ColorPrimary,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),

                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                            child: Text(
                              item.body,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
