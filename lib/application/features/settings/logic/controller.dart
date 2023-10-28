import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';

import '../state/livemodel.dart';
import '../ui/developer_contacts.dart';
import '../ui/display_language_selector.dart';

class SettingsController {
  SettingsController(this.settingsLiveModel);

  final SettingsLiveDataModel settingsLiveModel;

  void _onChangeDisplayLanguage(Locale locale) {
    settingsLiveModel.setDisplayLanguage(locale);
  }

  void changeDisplayLangauge(BuildContext context) {
    NavigationService.displayDialog(
      DisplayLanguageSelectorDialog(onConfirm: _onChangeDisplayLanguage),
    );
  }

  void changeAppTheme(BuildContext context) {}

  void displayAbout(BuildContext context) {
    NavigationService.displayDialog(
      const DeveloperContactDialog(),
    );
  }

  void displayStatistiques(BuildContext context) {
    NavigationService.pushNamed(Routes.statistiquesRoute);
  }

  void displaySearchStudent(BuildContext context) {
    NavigationService.pushNamed(Routes.searchStudentRoute);
  }

  void displaySearchGroup(BuildContext context) {
    NavigationService.pushNamed(Routes.searchGroupRoute);
  }
}
