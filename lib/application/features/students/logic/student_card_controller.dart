import 'package:zawya_islamic/application/features/students/state/bloc.dart';
import 'package:zawya_islamic/application/features/students/state/events.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

import '../ui/student_editor.dart';

class StudentCardController {
  const StudentCardController(this.localizations, this.bloc, this.groupId);

  final AppLocalizations localizations;
  final StudentsBloc bloc;
  final GroupId groupId;

  void onClick(Student student) {
    _onEdit(student);
  }

  Future<bool> onSwipe(Student student) async {
    final dialog = ConfirmationDialog(
        onConfirm: () {
          final event = DeleteStudentEvent(student: student);

          final options =
              DeleteStudentOptions(studentId: student.id, groupId: groupId);
          ServicesProvider.instance().studentService.deleteStudent(options);

          bloc.add(event);
          NavigationService.pop();
        },
        title: localizations.deleteLabel,
        content: localizations.permanentActionWarning);

    final dimsiss = await NavigationService.displayDialog(dialog);

    return dimsiss ?? false;
  }

  // ignore: unused_element
  void _onDelete(String content, String title, Student student) {
    final dialog = ConfirmationDialog(
        onConfirm: () {
          final event = DeleteStudentEvent(student: student);

          final options =
              DeleteStudentOptions(studentId: student.id, groupId: groupId);
          ServicesProvider.instance().studentService.deleteStudent(options);

          bloc.add(event);
        },
        title: title,
        content: content);

    NavigationService.displayDialog(dialog);
  }

  void _onEdit(Student student) {

    final dialog = StudentEditorDialog(
      student: student,
    );

    NavigationService.displayDialog(dialog);
  }
}
