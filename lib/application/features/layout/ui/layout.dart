import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/login/feature.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key,  this.displayAppBar = true});

  final bool displayAppBar;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      final selectedIndex = state.selectedIndex;

      return Scaffold(
        
        body: state.appsetupBuilder.bodyBuilder(selectedIndex),
        bottomNavigationBar: state.appsetupBuilder.bottomNavigationBarBuilder(
          selectedIndex,
        ),
      );
    });
  }
}
