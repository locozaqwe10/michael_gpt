import '/utilities/colors.dart';
import 'package:flutter/material.dart';

/// Creates a circular avatar with the first letter of the given name.
/// [name] - The full name of the user.
/// [radius] - The radius of the circular avatar.
/// [backgroundColor] - Optional background color.
/// [textColor] - Optional text color.
Widget circularAvatar({
  required String name,
  required double radius ,
  Color backgroundColor =ColorBgBlock,
  Color textColor = Colors.white,
}) {
  // Get first letter of name, uppercase
  String firstLetter = '';
  if (name.isNotEmpty) {
    firstLetter = name[0].toUpperCase();
  }

  return CircleAvatar(
    radius: radius,
    backgroundColor: backgroundColor,
    child: Text(
      firstLetter,
      style: TextStyle(
        color: textColor,
        fontSize: radius * 0.8, // Scale font size based on radius
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}