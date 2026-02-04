
import 'package:custom_chat_gpt/utilities/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Social login button widget
Widget socialButton({required IconData icon, required String text}) {
  return SizedBox(
    width: double.infinity,
    height: 52,
    child: OutlinedButton.icon(

      onPressed: () {},

      icon: Icon(icon, size: 28, color: ColorSecandory,fontWeight: FontWeight.w900,),
      label: Text(text, style: TextStyle(color: ColorSecandory),),
      style: OutlinedButton.styleFrom(

      backgroundColor: Colors.white,
        side: BorderSide(
          color: ColorPrimary, // Border color
          width: 2,            // Border thickness
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),


        ),
      ),
    ),
  );
}