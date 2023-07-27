import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/admin_app/layout/layout.dart';
import 'package:zawya_islamic/application/admin_app/schools/ports.dart';
import 'package:zawya_islamic/application/admin_app/schools/state/export.dart';
import 'package:zawya_islamic/application/features/layout/state/events.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/ports/school_service_port.dart';
import 'package:zawya_islamic/infrastructure/services/services_provider.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

import '../../../features/layout/state/bloc.dart';
import '../ui/school_editor.dart';

class SchoolCardController implements SchoolCardControllerPort {
  const SchoolCardController(this.schoolBloc, this.appBloc, this.localizations);
  final AppLocalizations localizations;

  final SchoolsBloc schoolBloc;
  final AppBloc appBloc;

  @override
  void onClick(School school) {
    appBloc.add(
      SetupAppEvent(
        const AdminAppSetupOptions(),
      ),
    );

    schoolBloc.add(SelectSchoolEvent(school: school));

    NavigationService.pushNamed(Routes.adminDashboardRoute);
  }

  @override
  void onMoreActions(
    School school,
  ) {
    _onEdit(school);
  }

  // ignore: unused_element
  void _onDelete(School school, String content, String title) {
    final dialog = ConfirmationDialog(
        onConfirm: () {
          final options = DeleteSchoolOptions(schoolId: school.id);

          ServicesProvider.instance()
              .schoolService
              .deleteSchool(options)
              .then((res) {
            schoolBloc.add(DeleteSchoolEvent(school: school));
            NavigationService.pop();
          });
        },
        title: title,
        content: content);

    NavigationService.replaceDialog(dialog);
  }

  void _onEdit(School school) {
    final dialog = SchoolEditorDialog(
      school: school,
    );

    NavigationService.replaceDialog(dialog);
  }

  @override
  bool get displayFloatingAction => true;

  @override
  bool get displayOnMoreActions => true;

  @override
  void onFloatingClick() {
    const dialog = SchoolEditorDialog();
    NavigationService.displayDialog(dialog);
  }

  @override
  Future<bool> onSwipe(School school, BuildContext context) async {
    final dialog = ConfirmationDialog(
        onConfirm: () {
          final options = DeleteSchoolOptions(schoolId: school.id);

          ServicesProvider.instance()
              .schoolService
              .deleteSchool(options)
              .then((res) {
            schoolBloc.add(DeleteSchoolEvent(school: school));
            NavigationService.pop();
          });
        },
        title: localizations.deleteLabel,
        content: localizations.permanentActionWarning);

    final dismiss = await NavigationService.displayDialog<bool>(dialog);

    return dismiss ?? false;
  }
}
