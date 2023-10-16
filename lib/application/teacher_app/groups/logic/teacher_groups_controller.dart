import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/login/feature.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/application/teacher_app/layout/layout.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/infrastructure/services/services_provider.dart';
import 'package:flutter/material.dart';

class TeacherGroupsController implements GroupCardControllerPort {
  const TeacherGroupsController(this.studentsBloc, this.appBloc);

  final StudentsBloc studentsBloc;
  final AppBloc appBloc;

  @override
  bool get displayOnMoreActions => false;

  @override
  void onClick(Group group) {
    studentsBloc.add(SetGroupEvent(group: group));
    appBloc.add(SetupAppEvent(const TeacherAppSetupOptions()));

    NavigationService.pushNamed(Routes.teacherDashboardRoute);

    _loadGroupStudentsPresenceAndEvluation(group);
  }

  @override
  void onMoreActions(Group group,  ) {
    throw UnimplementedError();
  }

  @override
  void onFloatingClick() {}

  void _loadGroupStudentsPresenceAndEvluation(Group group) {

    final options = LoadGroupPresenceAndEvaluationOptions(groupId: group.id);

    
    ServicesProvider.instance()
        .studentService
        .loadGroupPresenceAndEvaluations(options)
        .then((res) => studentsBloc.add(LoadPresencesAndEvaluations(evaluations: res.data)));
  }
  
  @override
  bool get displayFloatingActions => false;

  @override
  Future<bool> onSwipe(Group group, BuildContext context) {
    throw UnimplementedError();
  }
}
