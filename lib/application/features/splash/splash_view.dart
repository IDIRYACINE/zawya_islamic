import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/login/feature.dart';
import 'package:zawya_islamic/application/features/splash/logic.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';
import 'package:zawya_islamic/widgets/app_logo.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key, this.callback});

  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AppBloc>(context);

    ServicesProvider.instance().init().then((v) {
      navigateToMainApp(callback, authBloc);
    });

    return const Scaffold(
      body: Center(child: AppLogo()),
    );
  }
}
