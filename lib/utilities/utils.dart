import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
}