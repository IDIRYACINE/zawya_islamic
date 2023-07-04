

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zawya_islamic/application/admin_app/students/export.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';

class TeacherGroupsController implements GroupCardControllerPort {
  const TeacherGroupsController(this.bloc);

  final StudentsBloc bloc;

  @override
  bool get displayOnMoreActions => false;

  @override
  void onClick(Group group) {

    bloc.add(SetGroupEvent(group: group));

    NavigationService.pushNamedReplacement(Routes.teacherDashboardRoute);
  }

  @override
  void onMoreActions(Group group,AppLocalizations localizations) {
    throw UnimplementedError();
  }
}