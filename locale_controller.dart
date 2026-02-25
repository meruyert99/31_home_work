import 'package:flutter/material.dart';

class LocaleController extends ValueNotifier<Locale> {
  LocaleController() : super(const Locale('en'));

  void toggleRuEn() {
    value = (value.languageCode == 'en') ? const Locale('ru') : const Locale('en');
  }

  void setLocale(Locale locale) => value = locale;
}
