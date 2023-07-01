import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/navigation/navigation_service.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/utility/validators.dart';
import 'package:zawya_islamic/widgets/buttons.dart';

import '../logic/teacher_editor_controller.dart';

class TeacherEditor extends StatelessWidget {
  const TeacherEditor({super.key, this.teacher, required this.controller});

  final Teacher? teacher;

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
            decoration: InputDecoration(
                labelText: isEditing
                    ? localizations.editLabel
                    : localizations.addLabel),
            initialValue: initialValue,
            validator: (value) => teacherNameValidator(value, localizations),
            onChanged: controller.updateName,
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
    NavigationService.pop();
  }

  @override
  Widget build(BuildContext context) {
    final controller = TeacherEditorController();
    final localizations = AppLocalizations.of(context)!;
    final isEditing = teacher != null;

    return AlertDialog(
      title: Text(isEditing ? localizations.editLabel : localizations.addLabel),
      content: TeacherEditor(
        controller: controller,
        teacher: teacher,
      ),
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
