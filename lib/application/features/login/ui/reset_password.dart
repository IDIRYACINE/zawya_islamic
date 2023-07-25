import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/layout/state/bloc.dart';
import 'package:zawya_islamic/application/features/login/logic/controller.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/utility/validators.dart';
import 'package:zawya_islamic/widgets/buttons.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({super.key, required this.controller});

  final ResetPasswordController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.resetPasswordFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration:
                InputDecoration(labelText: controller.localizations.otpLabel),
            validator: (value) =>
                emptyValidator(value, controller.localizations),
            onChanged: controller.updateOtp,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: controller.localizations.loginPasswordLabel),
            validator: (value) =>
                passwordValidator(value, controller.localizations),
            onChanged: controller.updatePassword,
          ),
          const SizedBox(
            height: AppMeasures.space,
          ),
          TextButton(
            onPressed: () => controller.sendPasswordReset(true),
            child: Text(controller.localizations.resendPasswordReset),
          ),
          const SizedBox(
            height: AppMeasures.space,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              ButtonPrimary(
                  onPressed: controller.confirmPasswordReset,
                  text: controller.localizations.confirmLabel),
              TextButton(
                  onPressed: controller.cancel,
                  child: Text(controller.localizations.cancelLabel)),
            ],
          )
        ],
      ),
    );
  }
}

class ResetPasswordDialog extends StatefulWidget {
  ResetPasswordDialog() : super(key: ResetPasswordController.widgetKey);

  @override
  State<ResetPasswordDialog> createState() => ResetPasswordDialogState();
}

class RequestNewPasswordFrom extends StatelessWidget {
  const RequestNewPasswordFrom({super.key, required this.controller});

  final ResetPasswordController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.sendPasswordResetFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration:
                InputDecoration(labelText: controller.localizations.emailLabel),
            validator: (value) =>
                emailValidator(value, controller.localizations),
            onChanged: controller.updateEmail,
          ),
          const SizedBox(
            height: AppMeasures.space,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              ButtonPrimary(
                  onPressed: controller.sendPasswordReset,
                  text: controller.localizations.confirmLabel),
              TextButton(
                onPressed: controller.cancel,
                child: Text(controller.localizations.cancelLabel),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ResetPasswordDialogState extends State<ResetPasswordDialog> {
  bool isInit = false;
  bool otpSent = false;

  late ResetPasswordController controller;

  void updateState(bool value) {
    setState(() {
      otpSent = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isInit) {
      final bloc = BlocProvider.of<AppBloc>(context);
      final localizations = AppLocalizations.of(context)!;
      controller =
          ResetPasswordController(appBloc: bloc, localizations: localizations);
      isInit = true;
    }

    return AlertDialog(
      content: otpSent
          ? ResetPasswordForm(
              controller: controller,
            )
          : RequestNewPasswordFrom(
              controller: controller,
            ),
    );
  }
}
