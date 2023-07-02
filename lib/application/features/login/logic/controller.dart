import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/navigation/feature.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/auth_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';

import '../feature.dart';

class LoginController {
  static final key = GlobalKey<FormState>();

  String identifier = "";
  String password = "";

  void login(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    if (key.currentState!.validate()) {
      ServicesProvider.instance()
          .authService
          .login(identifier: identifier, password: password)
          .then((response) => _handleLoginResponse(response, authBloc));
    }
  }

  _handleLoginResponse(AuthResponse response, AuthBloc bloc) {
    if (response.success && response.data != null) {
      final event = LoginUserEvent(user: response.data!);
      bloc.add(event);
      _navigateToPathBasedOnUser(response.data!);
      return;
    }
  }

  void _navigateToPathBasedOnUser(User user) {

    switch (user.role) {

      case UserRoles.admin:
        NavigationService.pushNamedReplacement(Routes.adminAppRoute);
        break;

      case UserRoles.teacher:
        NavigationService.pushNamedReplacement(Routes.teacherAppRoute);

        break;
      case UserRoles.student:
        NavigationService.pushNamedReplacement(Routes.studentAppRoute);

        break;

      default:
        NavigationService.pushNamedReplacement(Routes.anonymousAppRoute);

        break;
    }
    
  }
}
