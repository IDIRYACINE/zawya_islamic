import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/login/feature.dart';

class AdminAppLayout extends StatelessWidget {
  const AdminAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      final selectedIndex = state.selectedIndex;

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: state.appsetupBuilder.bodyBuilder(selectedIndex),
        bottomNavigationBar: state.appsetupBuilder.bottomNavigationBarBuilder(
          selectedIndex,
        ),
      );
    });
  }
}
