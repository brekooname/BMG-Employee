import 'package:flutter/material.dart';

class Constant {
  static appSnackBar({
    required BuildContext context,
    required String text,
    Color? background = Colors.red,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        maxLines: 2,
        style: const TextStyle(),
      ),
      backgroundColor: background,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.fixed,
      elevation: 2,
      dismissDirection: DismissDirection.horizontal,
    ));
  }
}
