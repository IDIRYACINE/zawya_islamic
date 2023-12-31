import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/login/feature.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key, this.displayAppBar = true});

  final bool displayAppBar;

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () {
          NavigationService.pop();
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      final selectedIndex = state.selectedIndex;

      if (!state.loaded) {
        state.appsetupBuilder.dataLoader?.call(context);
      }

      return Scaffold(
        appBar: state.appsetupBuilder.appbarBuilder?.call(context) ??
            _buildAppBar(context),
        body: state.appsetupBuilder.bodyBuilder(selectedIndex),
        bottomNavigationBar: state.appsetupBuilder.bottomNavigationBarBuilder(
          selectedIndex,
        ),
      );
    });
  }
}
