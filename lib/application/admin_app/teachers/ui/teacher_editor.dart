import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/utility/validators.dart';
import 'package:zawya_islamic/widgets/buttons.dart';

import '../logic/teacher_editor_controller.dart';

class TeacherEditor extends StatelessWidget {
  const TeacherEditor(
      {super.key,
      this.teacher,
      required this.controller,
      required this.groups});

  final Teacher? teacher;
  final List<Group> groups;

  final TeacherEditorController controller;

  @override
  Widget build(BuildContext context) {
    final initialValue = teacher?.name.value ?? controller.teacherName;
    final localizations = AppLocalizations.of(context)!;
    final isEditing = teacher != null;

    return Form(
      key: TeacherEditorController.key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: localizations.nameLabel),
            initialValue: initialValue,
            validator: (value) => teacherNameValidator(value, localizations),
            onChanged: controller.updateName,
          ),
          if (!isEditing)
            TextFormField(
              decoration: InputDecoration(labelText: localizations.emailLabel),
              initialValue: initialValue,
              validator: (value) => emailValidator(value, localizations),
              onChanged: controller.updateEmail,
            ),
          if (!isEditing)
            TextFormField(
              decoration:
                  InputDecoration(labelText: localizations.loginPasswordLabel),
              initialValue: initialValue,
              validator: (value) => passwordValidator(value, localizations),
              onChanged: controller.updatePassword,
            ),
        ],
      ),
    );
  }
}

class TeacherEditorDialog extends StatelessWidget {
  const TeacherEditorDialog({super.key, this.teacher});

  final Teacher? teacher;

  void onCancel() {
    NavigationService.pop();
  }

  void onConfirm(TeacherEditorController controller) {
    controller.createOrUpdate(teacher);
  }

  @override
  Widget build(BuildContext context) {
    final controller = TeacherEditorController();
    final localizations = AppLocalizations.of(context)!;
    final isEditing = teacher != null;
    final groups = BlocProvider.of<GroupsBloc>(context).state.groups;

    return AlertDialog(
      title: Text(isEditing ? localizations.editLabel : localizations.addLabel),
      content: TeacherEditor(
        controller: controller,
        teacher: teacher,
        groups: groups,
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(localizations.cancelLabel),
        ),
        ButtonPrimary(
            onPressed: () => onConfirm(controller),
            text: localizations.confirmLabel),
      ],
    );
  }
}
