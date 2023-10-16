import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/login/ui/reset_password.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/auth_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

import '../feature.dart';

class LoginController {
  static final key = GlobalKey<FormState>();

  String _identifier = "";
  String _password = "";

  void login(AppBloc authBloc, [bool usingCache = false]) {
    final valid = usingCache ? true : key.currentState!.validate();

    if (valid) {
      ServicesProvider.instance()
          .authService
          .login(identifier: _identifier, password: _password)
          .then((response) => _handleLoginResponse(response, authBloc));
    }
  }

  void _handleLoginResponse(AuthResponse response, AppBloc bloc) {
    if (response.success && response.user != null) {
      final event = LoginUserEvent(user: response.user!);
      bloc.add(event);
      _navigateToPathBasedOnUser(response.user!);
      cacheLoginCredentials(_identifier, _password);
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

  void loginAnonymous(BuildContext context) {
    final authBloc = BlocProvider.of<AppBloc>(context);

    final user = User(
        id: UserId(""), name: Name("Anonymous"), role: UserRoles.anonymous);

    final event = LoginUserEvent(user: user);
    authBloc.add(event);
    _navigateToPathBasedOnUser(user);
  }

  void forgotPassword() {
    final dialog = ResetPasswordDialog();
    NavigationService.displayDialog(dialog);
  }

  void updateIdentifier(String value) {
    _identifier = value.replaceAll(" ", "");
  }

  void updatePassword(String value) {
    _password = value.replaceAll(" ", "");
  }

  void setCredentials(String identifier, String password) {
    updateIdentifier(identifier);
    updatePassword(password);
  }
}

class ResetPasswordController {
  final resetPasswordFormKey = GlobalKey<FormState>();
  final sendPasswordResetFormKey = GlobalKey<FormState>();
  static final widgetKey = GlobalKey<ResetPasswordDialogState>();

  final AppLocalizations localizations;
  final AppBloc appBloc;

  String? _otp;
  String? _newPassword;
  String? _email;

  ResetPasswordController({required this.localizations, required this.appBloc});

  void confirmPasswordReset() {
    final isValid =
        resetPasswordFormKey.currentState!.validate() && _email != null;

    if (isValid) {
      ServicesProvider.instance()
          .authService
          .setNewPassword(
              otp: _otp!, newPassword: _newPassword!, email: _email!)
          .then((value) {
        _displayPasswordResetStatus(value != null);
      });
    }
  }

  void _displayPasswordResetStatus(bool isSucess) {
    String message = isSucess
        ? localizations.passwordResetSuccess
        : localizations.passwordResetFail;

    final dialog = InfoDialog(
      message: message,
    );
    NavigationService.pop();
    NavigationService.displayDialog(dialog);
  }

  void cancel() {
    NavigationService.pop();
  }

  void sendPasswordReset([bool? skipValidation]) {
    final isValid =
        skipValidation ?? sendPasswordResetFormKey.currentState!.validate();

    if (isValid) {
      ServicesProvider.instance().authService.sendPasswordReset(email: _email!);
    }
    if (skipValidation == null || !skipValidation) {
      widgetKey.currentState!.updateState(true);
    }
  }

  void updateEmail(String value) {
    _email = value.replaceAll(" ", "");
  }

  void updatePassword(String value) {
    _newPassword = value.replaceAll(" ", "");
  }

  void updateOtp(String value) {
    _otp = value;
  }
}
