import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../translations/locale_keys.g.dart';
import '../../config/locale/app_localizations.dart';

class AppDialogs {
  static Future showAlertDialog(
      {required BuildContext context, required String message}) async {
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(message),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(AppLocalizations
                      .translate(LocaleKeys.ok)),
                ),
              ],
            ));
  }

  static Future showToast({
    required String message,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) async {
    await Fluttertoast.showToast(
      msg: message,
      gravity: gravity,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
