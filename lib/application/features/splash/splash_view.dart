import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/navigation/navigation_service.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';
import 'package:zawya_islamic/widgets/app_logo.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    
    ServicesProvider.instance().init().then(
        (value) => NavigationService.pushNamedReplacement(Routes.loginRoute));

    return const Scaffold(
      body: Center(child: AppLogo()),
    );
  }
}
