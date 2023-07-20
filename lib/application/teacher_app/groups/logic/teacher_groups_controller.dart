import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/login/feature.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/application/teacher_app/layout/layout.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/infrastructure/services/services_provider.dart';

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

    _loadGroupStudents(group);
  }

  @override
  void onMoreActions(Group group, AppLocalizations localizations) {
    throw UnimplementedError();
  }

  @override
  void onFloatingClick() {}

  void _loadGroupStudents(Group group) {
    final options = LoadStudentsOptions(groupId: group.id);
    ServicesProvider.instance()
        .studentService
        .getStudents(options)
        .then((res) => studentsBloc.add(LoadStudentsEvent(students: res.data)));
  }
}
