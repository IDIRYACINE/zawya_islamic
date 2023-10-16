import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/teachers/export.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/application/features/layout/logic/ports.dart';
import 'package:zawya_islamic/application/features/login/feature.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/loaded.dart';
import 'package:zawya_islamic/resources/resources.dart';

import 'helpers.dart';

typedef OnSelect = void Function(int index, AppBloc bloc);

class AdminBottomNavigationBar extends StatelessWidget {
  const AdminBottomNavigationBar({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;
  final double width = 30;
  final double height = 30;

  void onSelect(int index, AppBloc bloc) {
    bloc.add(NavigateIndexEvent(index));
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final bloc = BlocProvider.of<AppBloc>(context);

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) => onSelect(index, bloc),
      items: [
        BottomNavigationBarItem(
          icon: Image(
              image: LoadedAppResources.studentWhite,
              width: width,
              height: height),
          label: localizations.studentsLabel,
        ),
        BottomNavigationBarItem(
          icon: Image(
              image: LoadedAppResources.teacherWhite,
              width: width,
              height: height),
          label: localizations.teachersLabel,
        ),
        BottomNavigationBarItem(
          icon: Image(
              image: LoadedAppResources.groupsWhite,
              width: width,
              height: height),
          label: localizations.groupsLabel,
        ),
      ],
    );
  }
}

class AdminAppSetupOptions extends AppSetupOptions {
  const AdminAppSetupOptions()
      : super(
            bodyBuilder: buildBody,
            bottomNavigationBarBuilder: buildBottomNavigationBar,
            dataLoader: adminDataLoader,
            appbarBuilder: buildAppBar);

  static void adminDataLoader(BuildContext context) {
    loadGroups(context);
    loadStudents(context);
    loadTeachers(context);

    final bloc = BlocProvider.of<AppBloc>(context);
    bloc.add(DataLoadedEvent(true));
  }

  static Widget buildBottomNavigationBar(int index) {
    return AdminBottomNavigationBar(
      selectedIndex: index,
    );
  }

  static PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          NavigationService.pop();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(
            AppResources.settingsIcon,
            color: Colors.white,
          ),
          onPressed: () {
            NavigationService.pushNamed(Routes.settingsRoute);
          },
        ),
      ],
    );
  }

  static Widget buildBody(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return const StudentsView(
          displayAppBar: false,
        );

      case 1:
        return const TeachersView(
          displayAppBar: false,
        );

      default:
        return const GroupsView(
          displayAppBar: false,
        );
    }
  }
}
