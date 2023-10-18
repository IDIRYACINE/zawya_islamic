import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/infrastructure/services/services_provider.dart';

class GroupStudentsScheduleController {
  late GroupsBloc _groupsBloc;
  final Group group;
  late StudentsBloc _studentBloc;

  GroupStudentsScheduleController(BuildContext context, this.group) {
    _groupsBloc = BlocProvider.of<GroupsBloc>(context);
    _studentBloc = BlocProvider.of<StudentsBloc>(context);
  }

  void navigateToSchedule() {
    final options = LoadGroupScheduleOptions(groupId: group.id);
    ServicesProvider.instance()
        .groupService
        .loadGroupSchedule(options)
        .then((res) {
      _groupsBloc.add(
        SetWeekDaySchedulesEvent(schedules: res.data),
      );
    });

    _groupsBloc.add(SelectGroupEvent(group: group));

    NavigationService.pushNamed(Routes.groupScheduleRoute);
  }

  void navigateToStudents() {
    final options = LoadGroupPresenceAndEvaluationOptions(groupId: group.id);

    ServicesProvider.instance()
        .studentService
        .loadGroupPresenceAndEvaluations(options)
        .then(
          (res) => _studentBloc.add(
            LoadPresencesAndEvaluations(evaluations: res.data),
          ),
        );

    NavigationService.pushNamed(Routes.studentGroupStatistique);
  }
}
