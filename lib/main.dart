import 'package:flutter/material.dart';
import 'package:zawya_islamic/resources/metadata.dart';
import 'package:zawya_islamic/resources/themes.dart';

import 'application/features/settings/feature.dart';
import 'application/navigation/navigation_service.dart';
import 'resources/l10n/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final liveModel = SettingsLiveDataModel.instance();
    return AnimatedBuilder(
      animation: liveModel,
      builder: (context, child) {
        return MaterialApp(
          title: AppMetadata.appName,
          theme: AppThemes.lighTheme,
          locale: liveModel.displayLanguage,
          navigatorKey: NavigationService.key,
          onGenerateRoute: AppRouter.generateRoutes,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
