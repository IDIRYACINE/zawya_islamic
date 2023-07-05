
import 'package:zawya_islamic/application/admin_app/layout/layout.dart';
import 'package:zawya_islamic/application/admin_app/schools/state/export.dart';
import 'package:zawya_islamic/application/features/layout/state/events.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/buttons.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

import '../../../features/layout/state/bloc.dart';
import '../ui/school_editor.dart';

class SchoolCardController {
  const SchoolCardController(this.school, this.bloc, this.appBloc);

  final School school;
  final SchoolsBloc bloc;
  final AppBloc appBloc;

  void onClick() {
    
    appBloc.add(SetupAppEvent(const AdminAppSetupOptions()));

    NavigationService.pushNamedReplacement(Routes.adminDashboardRoute);
  }

  void onMoreActions(AppLocalizations localizations) {

    final options = [
      OptionsButtonData(callback: () => _onDelete(localizations.permanentActionWarning,localizations.deleteLabel), title: localizations.deleteLabel),
      OptionsButtonData(callback: _onEdit, title: localizations.editLabel)
    ];

    final dialog = OptionsAlertDialog(options: options);
    NavigationService.displayDialog(dialog);
  }

  void _onDelete(String content,String title) {
    final dialog = ConfirmationDialog(
      onConfirm:(){
        final event = DeleteSchoolEvent(school: school);
        bloc.add(event);
        NavigationService.pop();
      },
      title:title,
      content: content
    );

    NavigationService.replaceDialog(dialog);
  }

  void _onEdit() {

    final dialog = SchoolEditorDialog(
      school:school, 
    );

    NavigationService.replaceDialog(dialog);
  }
}
