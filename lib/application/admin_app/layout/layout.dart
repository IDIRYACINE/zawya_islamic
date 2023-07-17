import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/export.dart';
import 'package:zawya_islamic/application/admin_app/teachers/export.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/application/features/layout/logic/ports.dart';
import 'package:zawya_islamic/application/features/login/feature.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/core/ports/school_service_port.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/infrastructure/services/services_provider.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/resources.dart';

typedef OnSelect = void Function(int index, AppBloc bloc);

class AdminBottomNavigationBar extends StatelessWidget {
  const AdminBottomNavigationBar({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;

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
          icon: const Icon(AppResources.studentIcon),
          label: localizations.studentsLabel,
        ),
        BottomNavigationBarItem(
          icon: const Icon(AppResources.teacherIcon),
          label: localizations.teachersLabel,
        ),
        BottomNavigationBarItem(
          icon: const Icon(AppResources.groupIcon),
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
        );

  static void adminDataLoader(BuildContext context) {
    final servicesProvider = ServicesProvider.instance();

    final schoolsBloc = BlocProvider.of<SchoolsBloc>(context);

    final schoolsOptions = LoadSchoolsOptions();
    servicesProvider.schoolService
        .getSchools(schoolsOptions)
        .then((res) => schoolsBloc.add(LoadSchoolsEvent(schools: res.data)));
  }

  static Widget buildBottomNavigationBar(int index) {
    return AdminBottomNavigationBar(
      selectedIndex: index,
    );
  }

  static Widget buildBody(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return const StudentsView(
          displayAppBar: false,
          dataLoader: _loadStudents,
        );

      case 1:
        return const TeachersView(
          displayAppBar: false,
        );

      default:
        return const GroupsView(
          displayAppBar: false,
          dataLoader: _loadGroups,
        );
    }
  }
}

void _loadStudents(BuildContext context) {
  final studentsBloc = BlocProvider.of<StudentsBloc>(context);

  final schoolId =
      BlocProvider.of<SchoolsBloc>(context).state.selectedSchool!.id;

  final studentOptions = LoadStudentsOptions(schoolId: schoolId);
  ServicesProvider.instance().studentService.getStudents(studentOptions).then(
        (res) => studentsBloc.add(
          LoadStudentsEvent(students: res.data),
        ),
      );
}

void _loadGroups(BuildContext context) {
  final groupsBloc = BlocProvider.of<GroupsBloc>(context);

  final schoolId =
      BlocProvider.of<SchoolsBloc>(context).state.selectedSchool!.id;

  final groupOptions = LoadGroupsOptions(schoolId: schoolId);
  ServicesProvider.instance().groupService.loadGroups(groupOptions).then(
        (res) => groupsBloc.add(
          LoadGroupsEvent(groups: res.data),
        ),
      );
}
