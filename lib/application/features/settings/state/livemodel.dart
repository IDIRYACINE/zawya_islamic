import 'package:flutter/material.dart';
import 'package:zawya_islamic/resources/metadata.dart';

class SettingsLiveDataModel with ChangeNotifier {
  SettingsLiveDataModel._();



  static SettingsLiveDataModel? _instance;


  factory SettingsLiveDataModel.instance() {
    _instance ??= SettingsLiveDataModel._();
    return _instance!;
  }

  Locale displayLanguage = AppMetadata.localeEnglish;

  void setArabicLanguage() {
    displayLanguage =  AppMetadata.localeArabic;
    notifyListeners();
  }

  void setFrenchLanguage() {
    displayLanguage =  AppMetadata.localeFrench;
    notifyListeners();
  }

  void setEnglishLanguage() {
    displayLanguage = AppMetadata.localeEnglish;
    notifyListeners();
  }

  void setDisplayLanguage(Locale locale) {
    displayLanguage = locale;
    notifyListeners();
  }
}
