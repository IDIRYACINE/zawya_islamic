import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/navigation/navigation_service.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    
    Future.delayed(const Duration(seconds: 2), () {
      NavigationService.pushNamedReplacement(Routes.loginRoute);
    });

    return const Scaffold(
      body: Center(child: Text("Loading")),
    );
  }
}
