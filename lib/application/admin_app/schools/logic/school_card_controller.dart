import 'package:zawya_islamic/application/admin_app/layout/layout.dart';
import 'package:zawya_islamic/application/admin_app/schools/state/export.dart';
import 'package:zawya_islamic/application/features/layout/state/events.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/ports/school_service_port.dart';
import 'package:zawya_islamic/infrastructure/services/services_provider.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/buttons.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

import '../../../features/layout/state/bloc.dart';
import '../ui/school_editor.dart';

class SchoolCardController {
  const SchoolCardController(this.school, this.schoolBloc, this.appBloc);

  final School school;
  final SchoolsBloc schoolBloc;
  final AppBloc appBloc;

  void onClick() {
    appBloc.add(
      SetupAppEvent(
        const AdminAppSetupOptions(),
      ),
    );

    schoolBloc.add(SelectSchoolEvent(school: school));

    NavigationService.pushNamedReplacement(Routes.adminDashboardRoute);
  }

  void onMoreActions(AppLocalizations localizations) {
    final options = [
      OptionsButtonData(
          callback: () => _onDelete(
              localizations.permanentActionWarning, localizations.deleteLabel),
          title: localizations.deleteLabel),
      OptionsButtonData(callback: _onEdit, title: localizations.editLabel)
    ];

    final dialog = OptionsAlertDialog(options: options);
    NavigationService.displayDialog(dialog);
  }

  void _onDelete(String content, String title) {
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

  void _onEdit() {
    final dialog = SchoolEditorDialog(
      school: school,
    );

    NavigationService.replaceDialog(dialog);
  }
}
