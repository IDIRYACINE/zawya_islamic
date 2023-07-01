import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/admin_app/layout/ui/layout.dart';
import 'package:zawya_islamic/application/admin_app/schools/ui/schools_view.dart';
import 'package:zawya_islamic/application/features/login/ui/login_view.dart';
import 'package:zawya_islamic/application/features/splash/feature.dart';

import 'routes.dart';

abstract class AppRouter {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.adminAppRoute:
        return getPageRoute(settings: settings, view: const SchoolsView());

      case Routes.adminDashboardRoute:
        return getPageRoute(settings: settings, view: const AdminAppLayout());

      case Routes.loginRoute:
        return getPageRoute(settings: settings, view: const LoginView());

      default:
        return getPageRoute(
          settings: settings,
          view: const SplashView(),
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
