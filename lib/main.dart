import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/state/bloc.dart';
import 'package:zawya_islamic/application/features/students/state/bloc.dart';
import 'package:zawya_islamic/application/admin_app/teachers/state/bloc.dart';
import 'package:zawya_islamic/application/features/groups/state/bloc.dart';
import 'package:zawya_islamic/resources/metadata.dart';
import 'package:zawya_islamic/resources/themes.dart';

import 'application/features/login/feature.dart';
import 'application/features/settings/feature.dart';
import 'application/features/navigation/navigation_service.dart';
import 'resources/l10n/l10n.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SchoolsBloc>(
          create: (context) => SchoolsBloc(),
        ),
         BlocProvider<StudentsBloc>(
          create: (context) => StudentsBloc(),
        ),
         BlocProvider<TeachersBloc>(
          create: (context) => TeachersBloc(),
        ),
        BlocProvider<GroupsBloc>(
          create: (context) => GroupsBloc(),
        ),
         BlocProvider<AppBloc>(
          create: (context) => AppBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
          themeMode: ThemeMode.dark,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
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
