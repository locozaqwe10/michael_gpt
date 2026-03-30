
import '../utilities/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Social login button widget
Widget socialButton({required IconData icon, required String text}) {
  return SizedBox(
    width: double.infinity,
    height: 55,

    child: OutlinedButton.icon(

      onPressed: () {},

      icon: Icon(icon, size: 30, color: SubColorSecandory,fontWeight: FontWeight.w900,),
      label: Text("$text→", style: TextStyle(color: SubColorSecandory),),

      style: OutlinedButton.styleFrom(

      backgroundColor: ColorPrimary,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),


        ),
      ),
    ),
  );
}