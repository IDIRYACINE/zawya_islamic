import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/teachers/state/events.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/core/ports/teacher_service_port.dart';
import 'package:zawya_islamic/infrastructure/services/services_provider.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

import '../state/bloc.dart';
import '../ui/teacher_editor.dart';
import 'teacher_group_controller.dart';

class TeacherCardController {
  const TeacherCardController(this.localizations, this.bloc, this.schoolId);

  final AppLocalizations localizations;

  final TeachersBloc bloc;
  final SchoolId schoolId;

  void onClick(BuildContext context, Teacher teacher) {
    final groupsBloc = BlocProvider.of<GroupsBloc>(context);
    final userId = teacher.id.toUserId();

    final widget = GroupsView(
      controllerPort: TeacherAdminGroupController(groupsBloc, userId,localizations),
      usePrimarySource: false,
      dataLoader: (context) => loadTeacherGroups(context, teacher.id),
    );

    NavigationService.push(widget);
  }

  void onMoreActions(Teacher teacher) {
    _onEdit(teacher);
  }

  void _onEdit(Teacher teacher) {
    final dialog = TeacherEditorDialog(
      teacher: teacher,
    );

    NavigationService.displayDialog(dialog);
  }

  Future<bool> onSwipe(Teacher teacher, BuildContext context) async {
    final dialog = ConfirmationDialog(
        onConfirm: () {
          final event = DeleteTeacherEvent(teacher: teacher);
          bloc.add(event);

          final options =
              DeleteTeacherOptions(teacherId: teacher.id, schoolId: schoolId);
          ServicesProvider.instance().teacherService.deleteTeacher(options);

          NavigationService.pop();
        },
        title: localizations.deleteLabel,
        content: localizations.permanentActionWarning);

    final dismiss = await NavigationService.displayDialog<bool>(dialog);

    return dismiss ?? false;
  }
}


void loadTeacherGroups(BuildContext context, TeacherId teacherId) {
  final groupsBloc = BlocProvider.of<GroupsBloc>(context);

  final options = LoadTeacherGroupsOptions(teacherId: teacherId);

  ServicesProvider.instance().groupService.getTeacherGroups(options).then(
      (res) =>
          groupsBloc.add(LoadGroupsEvent(groups: res.data, isPrimary: false)));
}
