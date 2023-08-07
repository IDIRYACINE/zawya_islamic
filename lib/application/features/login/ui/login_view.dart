import 'package:flutter/material.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/widgets/app_logo.dart';
import 'package:zawya_islamic/widgets/customs.dart';
import '../logic/controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late AppLocalizations localizations;
  late Size size;
  late ThemeData theme;
  late TextStyle textStyle;
  late LoginController controller;

  @override
  void initState() {
    super.initState();

    controller = LoginController();
  }

  @override
  Widget build(BuildContext context) {
    const borderLineStyle = UnderlineInputBorder();
    localizations = AppLocalizations.of(context)!;
    size = MediaQuery.of(context).size;
    theme = Theme.of(context);
    textStyle =
        theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.primary);

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
                    style: textStyle,
                    decoration: InputDecoration(
                        hintText: localizations.loginUsernameLabel,
                        enabledBorder: borderLineStyle),
                    onChanged: controller.updateIdentifier,
                  ),
                  const SizedBox(height: AppMeasures.space),
                  TextFormField(
                      style: textStyle,
                      decoration: InputDecoration(
                          enabledBorder: borderLineStyle,
                          hintText: localizations.loginPasswordLabel),
                      obscureText: true,
                      onChanged: controller.updatePassword),
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
