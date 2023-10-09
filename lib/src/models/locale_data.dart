import 'package:flutter/material.dart';

class LocaleData {
  Locale locale;
  String languageName;
  String countryName;
  String languageCode;
  String flag;

  LocaleData({
    required this.locale,
    required this.languageName,
    required this.countryName,
    required this.languageCode,
    required this.flag,
  });
}
