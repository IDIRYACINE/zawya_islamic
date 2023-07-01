import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/navigation/navigation_service.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/utility/validators.dart';
import 'package:zawya_islamic/widgets/buttons.dart';

import '../logic/group_editor_controller.dart';

class GroupEditor extends StatelessWidget {
  const GroupEditor({super.key, this.group, required this.controller});

  final Group? group;

  final GroupEditorController controller;

  @override
  Widget build(BuildContext context) {
    final initialValue = group?.name.value ?? controller.groupName;
    final localizations = AppLocalizations.of(context)!;
    final isEditing = group != null;

    return Form(
      key: GroupEditorController.key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
                labelText: isEditing
                    ? localizations.editLabel
                    : localizations.addLabel),
            initialValue: initialValue,
            validator: (value) => groupNameValidator(value, localizations),
            onChanged: controller.updateName,
          ),
        ],
      ),
    );
  }
}

class GroupEditorDialog extends StatelessWidget {
  const GroupEditorDialog({super.key, this.group});

  final Group? group;

  void onCancel() {
    NavigationService.pop();
  }

  void onConfirm(GroupEditorController controller) {
    controller.createOrUpdate(group);
    NavigationService.pop();
  }

  @override
  Widget build(BuildContext context) {
    final controller = GroupEditorController();
    final localizations = AppLocalizations.of(context)!;
    final isEditing = group != null;

    return AlertDialog(
      title: Text(isEditing ? localizations.editLabel : localizations.addLabel),
      content: GroupEditor(
        controller: controller,
        group: group,
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
