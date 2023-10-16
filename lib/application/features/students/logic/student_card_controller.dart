import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/students/state/bloc.dart';
import 'package:zawya_islamic/application/features/students/state/events.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

import '../ui/student_editor.dart';
import 'student_group_controller.dart';

class StudentCardController {
  const StudentCardController(this.localizations, this.bloc, this.groupId);

  final AppLocalizations localizations;
  final StudentsBloc bloc;
  final GroupId groupId;

  void onClick(BuildContext context,Student student) {
    final groupsBloc = BlocProvider.of<GroupsBloc>(context);
    final userId = student.id.toUserId();

    final widget = GroupsView(
      controllerPort: StudentAdminGroupController(groupsBloc, userId,localizations),
      usePrimarySource: false,
      dataLoader: (context) => loadStudentGroups(context, student.id),
    );

    NavigationService.push(widget);
  }

  void onMoreActions(Student student) {
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
  void _onEdit(Student student) {

    final dialog = StudentEditorDialog(
      student: student,
    );

    NavigationService.displayDialog(dialog);
  }
}


void loadStudentGroups(BuildContext context, StudentId studentId) {
  final groupsBloc = BlocProvider.of<GroupsBloc>(context);

  final options = LoadStudentGroupsOptions(studentId: studentId);

  ServicesProvider.instance().groupService.getStudentGroups(options).then(
      (res) =>
          groupsBloc.add(LoadGroupsEvent(groups: res.data, isPrimary: false)));
}
