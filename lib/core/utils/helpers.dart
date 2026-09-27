import 'package:flutter/material.dart';

class Helpers {
  Helpers._();

  static void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static Future<void> delay({
    int milliseconds = 300,
  }) async {
    await Future.delayed(
      Duration(milliseconds: milliseconds),
    );
  }
}