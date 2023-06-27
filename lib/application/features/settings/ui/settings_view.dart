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
    final theme = Theme.of(context);
    final controller = SettingsController(SettingsLiveDataModel.instance());
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(AppMeasures.paddingsLarge),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.settings,
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(
              height: AppMeasures.space,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
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
                const SizedBox(
                  width: 20,
                ),
                SettingCard(
                  sectionTitle: localizations.general,
                  rowData: const [
                    
                   
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
