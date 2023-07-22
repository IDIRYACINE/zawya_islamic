import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/auth_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

import '../feature.dart';

class LoginController {
  static final key = GlobalKey<FormState>();

  String identifier = "idiryacinesp@gmail.com";
  String password = "idiryacine";

  void login(BuildContext context) {
    final authBloc = BlocProvider.of<AppBloc>(context);

    if (key.currentState!.validate()) {
      ServicesProvider.instance()
          .authService
          .login(identifier: identifier, password: password)
          .then((response) => _handleLoginResponse(response, authBloc));
    }
  }

  void _handleLoginResponse(AuthResponse response, AppBloc bloc) {
    if (response.success && response.user != null) {
      final event = LoginUserEvent(user: response.user!);
      bloc.add(event);
      _navigateToPathBasedOnUser(response.user!);
      return;
    }

    const dialog = InfoDialog(
      message: 'كلمة المرور او المستخدم خاطئ',
    );

    NavigationService.displayDialog(dialog);
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
