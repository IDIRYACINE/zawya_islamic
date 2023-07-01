
import 'package:zawya_islamic/application/admin_app/schools/logic/school_editor_controller.dart';
import 'package:zawya_islamic/application/admin_app/schools/state/export.dart';
import 'package:zawya_islamic/application/navigation/feature.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/buttons.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

import '../ui/school_editor.dart';

class SchoolCardController {
  const SchoolCardController(this.school, this.bloc);

  final School school;
  final SchoolsBloc bloc;

  void onClick() {
    final dialog = SchoolEditorDialog(
      school: school,
    );
    NavigationService.displayDialog(dialog);
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
      },
      title:title,
      content: content
    );

    NavigationService.displayDialog(dialog);
  }

  void _onEdit() {

    final dialog = SchoolEditor(
      school:school, 
      controller: SchoolEditorController(school.name.value),
    );

    NavigationService.displayDialog(dialog);
  }
}
