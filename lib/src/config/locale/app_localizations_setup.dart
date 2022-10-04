import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class AppLocalizationsSetup {
  static List<Locale> supportedLocales = supportedLocalesLanguageCodes
      .map((languageCode) => Locale(languageCode))
      .toList();

  static const List<String> supportedLocalesLanguageCodes = [
    'en',
    'ar',
  ];

  static ensureInitialized() async =>
      await EasyLocalization.ensureInitialized();

  static EasyLocalization initLocalization({required Widget app}) =>
      EasyLocalization(
        supportedLocales: AppLocalizationsSetup.supportedLocales,
        ///json files path
        path: "assets/translations",
        /// if chosen lang not available fall back to this Locale
        fallbackLocale: const Locale('en'),
        useOnlyLangCode: true,
        child: app,
      );
}
