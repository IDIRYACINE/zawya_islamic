import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';
import 'package:zawya_islamic/widgets/app_logo.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key, this.callback});

  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    ServicesProvider.instance().init().then((v) {
      if (callback == null) {
        NavigationService.pushNamedReplacement(Routes.loginRoute);
        return;
      }
      callback?.call();
    });

    return const Scaffold(
      body: Center(child: AppLogo()),
    );
  }
}
