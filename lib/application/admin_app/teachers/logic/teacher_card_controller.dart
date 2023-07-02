
import 'package:zawya_islamic/application/admin_app/teachers/state/events.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/buttons.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

import '../state/bloc.dart';
import '../ui/teacher_editor.dart';

class TeacherCardController {
  const TeacherCardController(this.teacher, this.bloc);

  final Teacher teacher;
  final TeachersBloc bloc;

  void onClick() {
    
    // NavigationService.pushNamedReplacement(Routes.adminDashboardRoute);
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
        final event = DeleteTeacherEvent(teacher: teacher);
        bloc.add(event);
        NavigationService.pop();
      },
      title:title,
      content: content
    );

    NavigationService.replaceDialog(dialog);
  }

  void _onEdit() {

    final dialog = TeacherEditorDialog(
      teacher:teacher, 
    );

    NavigationService.replaceDialog(dialog);
  }
}
