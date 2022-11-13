import 'package:flutter/material.dart';

import '../../../translations/locale_keys.g.dart';
import '../../config/locale/app_localizations.dart';
import 'app_strings.dart';

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

  static Future showUnDismissibleDialog({required BuildContext context})async{
    await showDialog(
      barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              title: const Text(AppStrings.appNeedsUpdate),
              actions: [
                ElevatedButton(
                  //ToDo Routes to Google PlayStore or whatever
                  onPressed: null,
                  child: Text(AppLocalizations
                      .translate(LocaleKeys.ok)),
                ),
              ],
            ));
  }
  static appSnackBar({
    required BuildContext context,
    required String text,
    Color? background = Colors.red,
    int durationInSeconds=3,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        maxLines: 2,
        style: const TextStyle(),
      ),
      backgroundColor: background,
      duration: Duration(seconds: durationInSeconds),
      behavior: SnackBarBehavior.fixed,
      elevation: 2,
      dismissDirection: DismissDirection.horizontal,
    ));
  }

}
