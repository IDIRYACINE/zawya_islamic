import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/anonymous_app/ui/anonymous_schools_view.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/groups/ui/group_schedule_view.dart';
import 'package:zawya_islamic/application/features/layout/ui/layout.dart';
import 'package:zawya_islamic/application/admin_app/schools/ui/schools_view.dart';
import 'package:zawya_islamic/application/features/login/ui/login_view.dart';
import 'package:zawya_islamic/application/features/settings/feature.dart';
import 'package:zawya_islamic/application/features/splash/feature.dart';
import 'package:zawya_islamic/application/features/statistiques/export.dart';
import 'package:zawya_islamic/application/features/statistiques/ui/student_statistiques_view.dart';
import 'package:zawya_islamic/application/teacher_app/export.dart';
import 'package:zawya_islamic/widgets/customs.dart';

import 'routes.dart';

abstract class AppRouter {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.adminAppRoute:
        return getPageRoute(settings: settings, view: const SchoolsView());

      case Routes.adminDashboardRoute:
        return getPageRoute(settings: settings, view: const AppLayout());

      case Routes.groupsRoute:
        final arguments = settings.arguments as GroupViewRouteArguments?;

        return getPageRoute(
            settings: settings,
            view: GroupsView(
              controllerPort: arguments?.controllerPort,
              dataLoader: arguments?.dataLoader,
            ));

      case Routes.anonymousAppRoute:
        return getPageRoute(
            settings: settings, view: const AnonymousSchoolsView());

      case Routes.loginRoute:
        return getPageRoute(settings: settings, view: const BackgroundPattern(child:  LoginView()));

      case Routes.teacherAppRoute:
        return getPageRoute(
            settings: settings, view: const TeacherGroupsView());

      case Routes.teacherDashboardRoute:
        return getPageRoute(settings: settings, view: const AppLayout());

      case Routes.settingsRoute:
        return getPageRoute(settings: settings, view: const SettingsView());

      case Routes.studentGroupStatistique:
        return getPageRoute(
            settings: settings, view: const GroupStudentStatistiques());

      case Routes.statistiquesRoute:
        return getPageRoute(settings: settings, view: const StatistiquesView());

      case Routes.groupScheduleRoute:
        final arguments =
            settings.arguments as GroupScheduleViewRouteArguments?;
        return getPageRoute(
            settings: settings,
            view: GroupScheduleView(
              viewController: arguments?.viewController,
            ));

      default:
        return getPageRoute(
          settings: settings,
          view: BackgroundPattern(
            child: SplashView(
              callback: settings.arguments as VoidCallback?,
            ),
          ),
        );
    }
  }

  static PageRoute<dynamic> getPageRoute({
    required RouteSettings settings,
    required Widget view,
  }) {
    return Platform.isIOS
        ? CupertinoPageRoute(settings: settings, builder: (_) => view)
        : MaterialPageRoute(settings: settings, builder: (_) => view);
  }
}
