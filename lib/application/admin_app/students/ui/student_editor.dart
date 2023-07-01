import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/navigation/navigation_service.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/utility/validators.dart';
import 'package:zawya_islamic/widgets/buttons.dart';
import 'package:zawya_islamic/widgets/fields.dart';

import '../logic/student_editor_controller.dart';


class StudentEditor extends StatelessWidget {
  const StudentEditor({super.key, this.student, required this.controller,});

  final Student? student;

  final StudentEditorController controller;

  @override
  Widget build(BuildContext context) {
    final initialValue = student?.name.value ?? "";
    final controller = StudentEditorController();
    final localizations = AppLocalizations.of(context)!;

    return Form(
      key: StudentEditorController.key,
      child: Column(
        children: [
          TextFormField(
            decoration:
                InputDecoration(labelText: localizations.addSchoolLabel),
            initialValue: initialValue,
            validator: (value) => studentNameValidator(value, localizations),
            onChanged: controller.updateName,
          ),
          BirthDateField(
            onChanged: controller.updateBirthDate,
          )
        ],
      ),
    );
  }
}

class StudentEditorDialog extends StatelessWidget {
  const StudentEditorDialog({super.key, this.student});

  final Student? student;

  void onCancel() {
    NavigationService.pop();
  }

  void onConfirm(StudentEditorController controller) {
    controller.createOrUpdate(student);
    NavigationService.pop();
  }

  @override
  Widget build(BuildContext context) {
    final controller = StudentEditorController();
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.addSchoolLabel),
      content: StudentEditor(
        controller: controller,
        student: student,
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
