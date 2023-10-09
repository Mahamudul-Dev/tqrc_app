import 'dart:ui';

import 'package:get/get.dart';
import 'package:tqrc_app/localization/language/dutch.dart';
import 'package:tqrc_app/localization/language/english.dart';
import 'package:tqrc_app/src/models/locale_data.dart';
import 'package:tqrc_app/src/utils/asset_path.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "nl_NL": dutchLanguage,
        "en_US": englishLanguage,
      };

  static final locals = [
    LocaleData(
      locale: const Locale('nl', 'NL'),
      languageName: 'Dutch',
      countryName: 'Netherlands',
      languageCode: 'NL',
      flag: AssetPath.netherLandsFlagIcon,
    ),
    LocaleData(
      locale: const Locale('en', 'US'),
      languageName: 'English',
      countryName: 'United English',
      languageCode: 'EN',
      flag: AssetPath.usaFlagIcon,
    ),
  ];
}
