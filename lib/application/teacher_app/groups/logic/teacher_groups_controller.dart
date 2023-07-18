

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/login/feature.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/application/teacher_app/layout/layout.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';

class TeacherGroupsController implements GroupCardControllerPort {
  const TeacherGroupsController(this.studentsBloc,this.appBloc);

  final StudentsBloc studentsBloc;
  final AppBloc appBloc;

  @override
  bool get displayOnMoreActions => false;

  @override
  void onClick(Group group) {

    studentsBloc.add(SetGroupEvent(group: group));
    appBloc.add(SetupAppEvent(const TeacherAppSetupOptions()));

    NavigationService.pushNamedReplacement(Routes.teacherDashboardRoute);
  }

  @override
  void onMoreActions(Group group,AppLocalizations localizations) {
    throw UnimplementedError();
  }
  
  @override
  void onFloatingClick() {
  }
}