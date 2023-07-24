import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/features/splash/feature.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import '../logic/controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final controller = LoginController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppMeasures.paddingsLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Logo(),
              Form(
                key:  LoginController.key,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: localizations.loginUsernameLabel),
                      onChanged: (value) => controller.identifier = value,
                    ),
                    const SizedBox(height: AppMeasures.space),
                    TextFormField(
                        decoration: InputDecoration(
                            hintText: localizations.loginPasswordLabel),
                        onChanged: (value) => controller.password = value),
                    const SizedBox(height: AppMeasures.space),
                    MaterialButton(
                      onPressed: () => controller.login(context),
                      child: Text(localizations.loginButtonLabel),
                    ),
                    const Divider(height: 2,),
                     MaterialButton(
                      onPressed: () => controller.loginAnonymous(context),
                      child: Text(localizations.loginAnonymous),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
