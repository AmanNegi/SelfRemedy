import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// helper functions
Size getSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

goToPage(BuildContext context, Widget destination, {bool clearStack = false}) {
  if (clearStack) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => destination), (route) => false);
  }
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => destination));
}

void showToast(String msg) {
  Fluttertoast.showToast(msg: msg);
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
// Colors

const Color accentColor = Color(0xFF734acc);
const Color lightColor = Color(0xFFedd2ff);
const Color mediumOpacityColor = Color(0xFFe173fc);
const Color darkColor  = Color(0xFF362866);