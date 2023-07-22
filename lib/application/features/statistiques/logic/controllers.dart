import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';

class StatistiquesGroupController implements GroupCardControllerPort {
  final StudentsBloc _studentBloc;

  StatistiquesGroupController(this._studentBloc);

  @override
  bool get displayOnMoreActions => false;

  @override
  void onClick(Group group) {
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

  @override
  void onFloatingClick() {}

  @override
  void onMoreActions(Group group, AppLocalizations localizations) {}
}
