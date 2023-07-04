
import 'package:zawya_islamic/application/features/students/state/bloc.dart';
import 'package:zawya_islamic/application/features/students/state/events.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/buttons.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

import '../ui/student_editor.dart';


class StudentCardController {
  const StudentCardController(this.student, this.bloc);

  final Student student;
  final StudentsBloc bloc;

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
        final event = DeleteStudentEvent(student: student);
        bloc.add(event);
        NavigationService.pop();
      },
      title:title,
      content: content
    );

    NavigationService.replaceDialog(dialog);
  }

  void _onEdit() {

    final dialog = StudentEditorDialog(
      student:student, 
    );

    NavigationService.replaceDialog(dialog);
  }
}
