import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/teachers/state/events.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/teacher_service_port.dart';
import 'package:zawya_islamic/infrastructure/services/services_provider.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/buttons.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

import '../state/bloc.dart';
import '../ui/teacher_editor.dart';
import 'teacher_group_controller.dart';

class TeacherCardController {
  const TeacherCardController(this.teacher, this.bloc, this.schoolId);

  final Teacher teacher;
  final TeachersBloc bloc;
  final SchoolId schoolId;

  void onClick(BuildContext context) {
    final groupsBloc = BlocProvider.of<GroupsBloc>(context);
    final userId = teacher.id.toUserId();

    final widget = GroupsView(
        controllerPort: TeacherAdminGroupController(groupsBloc,userId),
        usePrimarySource: false,
        );

    NavigationService.push(widget);
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
          final event = DeleteTeacherEvent(teacher: teacher);
          bloc.add(event);

          final options =
              DeleteTeacherOptions(teacherId: teacher.id, schoolId: schoolId);
          ServicesProvider.instance().teacherService.deleteTeacher(options);

          NavigationService.pop();
        },
        title: title,
        content: content);

    NavigationService.replaceDialog(dialog);
  }

  void _onEdit() {
    final dialog = TeacherEditorDialog(
      teacher: teacher,
    );

    NavigationService.replaceDialog(dialog);
  }
}
