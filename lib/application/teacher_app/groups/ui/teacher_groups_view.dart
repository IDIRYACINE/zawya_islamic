import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/export.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/login/feature.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';

import '../logic/teacher_groups_controller.dart';

class TeacherGroupsView extends StatelessWidget {
  const TeacherGroupsView({super.key});

  void _onReturn(BuildContext context) {
    BlocProvider.of<AppBloc>(context).add(LogoutEvent());

    NavigationService.pushNamedReplacement(Routes.loginRoute);
  }

  void _loadGroups(BuildContext context) {
    final groupsBloc = BlocProvider.of<GroupsBloc>(context);

    final schoolId =
        BlocProvider.of<SchoolsBloc>(context).state.selectedSchool?.id;

    final userId = BlocProvider.of<AppBloc>(context).state.user?.id;    

    final groupOptions = LoadTeacherGroupsOptions(schoolId: schoolId, teacherId: userId?.toTeacherId());

    ServicesProvider.instance().groupService.getTeacherGroups(groupOptions).then(
          (res) => groupsBloc.add(
            LoadGroupsEvent(groups: res.data),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final studentBloc = BlocProvider.of<StudentsBloc>(context);
    final appBloc = BlocProvider.of<AppBloc>(context);

    return GroupsView(
      displayAppBar: true,
      onReturn: () => _onReturn(context),
      displayFloatingAction: false,
      controllerPort: TeacherGroupsController(studentBloc, appBloc),
      dataLoader: _loadGroups,
    );
  }
}
