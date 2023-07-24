import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:flutter/material.dart';

import '../logic/controller.dart';
import '../state/livemodel.dart';
import 'setting_card.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController(SettingsLiveDataModel.instance());
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppMeasures.paddings),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingCard(
                sectionTitle: localizations.general,
                rowData: [
                  SettingRowData(
                    title: localizations.displayLanguage,
                    onClick: () {
                      controller.changeDisplayLangauge(context);
                    },
                  ),
                  SettingRowData(
                    title: localizations.statistiques,
                    onClick: () {
                      controller.displayStatistiques(context);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: AppMeasures.space,
              ),
              SettingCard(
                sectionTitle: localizations.about,
                rowData: [
                  SettingRowData(
                    title: localizations.developerContact,
                    onClick: () {
                      controller.displayAbout(context);
                    },
                  ),
                  SettingRowData(
                    title: localizations.appVersion,
                    subtitle: 'v 0.0.1',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
