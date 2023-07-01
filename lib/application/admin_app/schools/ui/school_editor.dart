import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/navigation/navigation_service.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/utility/validators.dart';
import 'package:zawya_islamic/widgets/buttons.dart';

import '../logic/school_editor_controller.dart';

class SchoolEditor extends StatelessWidget {
  const SchoolEditor({super.key, this.school, required this.controller});

  final School? school;

  final SchoolEditorController controller;


  @override
  Widget build(BuildContext context) {
    final initialValue = school?.name.value ?? controller.schoolName;
    final localizations = AppLocalizations.of(context)!;
    final isEditing = school != null;


    return Form(
      key: SchoolEditorController.key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
                labelText: isEditing
                    ? localizations.editLabel
                    : localizations.addSchoolLabel),
            initialValue: initialValue,
            validator: (value) => schoolNameValidator(value, localizations),
            onChanged: controller.updateName,
          ),
        ],
      ),
    );
  }
}

class SchoolEditorDialog extends StatelessWidget {
  const SchoolEditorDialog({super.key, this.school});

  final School? school;

  void onCancel() {
    NavigationService.pop();
  }

  void onConfirm(SchoolEditorController controller) {
    controller.createOrUpdate(school);
    NavigationService.pop();
  }

  @override
  Widget build(BuildContext context) {
    final controller = SchoolEditorController();
    final localizations = AppLocalizations.of(context)!;
    final isEditing = school != null;

    return AlertDialog(
      title: Text(
          isEditing ? localizations.editLabel : localizations.addSchoolLabel),
      content: SchoolEditor(
        controller: controller,
        school: school,
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
