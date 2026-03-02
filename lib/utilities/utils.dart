import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class mUtils{

  static void flushBarErrorMessages(String message, BuildContext context) {
    // top orientaion, animation we can cutom it later
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      )..show(context),
    );
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

 static  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    return emailRegex.hasMatch(email);
  }
}