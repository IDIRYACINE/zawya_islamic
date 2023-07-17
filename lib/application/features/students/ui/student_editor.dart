import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/utility/validators.dart';
import 'package:zawya_islamic/widgets/buttons.dart';
import 'package:zawya_islamic/widgets/fields.dart';

import '../logic/student_editor_controller.dart';

class StudentEditor extends StatelessWidget {
  const StudentEditor({
    super.key,
    this.student,
    required this.controller,
  });

  final Student? student;

  final StudentEditorController controller;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final groups = BlocProvider.of<GroupsBloc>(context).state.groups;


    return Form(
      key: StudentEditorController.key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: localizations.nameLabel),
            initialValue: controller.studentName,
            validator: (value) => studentNameValidator(value, localizations),
            onChanged: controller.updateName,
          ),
          BirthDateField(
            onChanged: controller.updateBirthDate,
            initialValue: controller.birthDate
          ),
          GroupSelector(groups: groups, onSelected: controller.updateGroup,
          
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
    final controller = StudentEditorController(student);
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(localizations.addLabel),
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
