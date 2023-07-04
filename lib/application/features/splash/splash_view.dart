import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/widgets/app_logo.dart';

import 'test_helper.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // ServicesProvider.instance().init().then(
    //     (value) => NavigationService.pushNamedReplacement(Routes.loginRoute));

    final bloc = BlocProvider.of<GroupsBloc>(context);
    final studentBloc = BlocProvider.of<StudentsBloc>(context);

    Future.delayed(const Duration(seconds: 2))
    .then((v) {
      loadTestStudent(studentBloc);
      loadTestGroups(bloc);
      NavigationService.pushNamedReplacement(Routes.loginRoute);
    });

    return const Scaffold(
      body: Center(child: AppLogo()),
    );
  }
}
