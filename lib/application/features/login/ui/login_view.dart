import 'package:flutter/material.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/widgets/app_logo.dart';
import 'package:zawya_islamic/widgets/customs.dart';
import '../logic/controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final controller = LoginController();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BackgroundPattern(
        child: Padding(
          padding: const EdgeInsets.all(AppMeasures.paddingsLarge),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppLogo(
                height: size.height * 0.2,
              ),
              Form(
                key: LoginController.key,
                child: Column(children: [
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: localizations.loginUsernameLabel),
                    onChanged: (value) => controller.identifier = value,
                  ),
                  const SizedBox(height: AppMeasures.space),
                  TextFormField(
                      decoration: InputDecoration(
                          hintText: localizations.loginPasswordLabel),
                      obscureText: true,
                      onChanged: (value) => controller.password = value),
                ]),
              ),
              const SizedBox(height: AppMeasures.space),
              MaterialButton(
                onPressed: () => controller.login(context),
                child: Text(localizations.loginButtonLabel),
              ),
              const Divider(
                height: 2,
              ),
              MaterialButton(
                onPressed: () => controller.loginAnonymous(context),
                child: Text(localizations.loginAnonymous),
              ),
              TextButton(
                  onPressed: controller.forgotPassword,
                  child: Text(localizations.forgotPasswordLabel))
            ],
          ),
        ),
      ),
    );
  }
}
