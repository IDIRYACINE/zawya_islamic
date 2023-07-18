import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/ports/types.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/widgets/buttons.dart';

class GroupSelector extends StatefulWidget {
  const GroupSelector(
      {super.key,
      required this.groups,
      required this.onSelected,
      this.validator});

  final List<Group> groups;
  final OnGroupSelectedCallback onSelected;
  final FormFieldValidator? validator;

  @override
  State<StatefulWidget> createState() => _GroupSelectorState();
}

class _GroupSelectorState extends State<GroupSelector> {
  List<DropdownMenuItem<Group>> buildItems() {
    final List<DropdownMenuItem<Group>> items = [];

    for (Group group in widget.groups) {
      items.add(DropdownMenuItem(value: group, child: Text(group.name.value)));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Group>(
        validator: widget.validator,
        items: buildItems(),
        onChanged: widget.onSelected);
  }
}

class GroupSelectorDialog extends StatefulWidget {
  const GroupSelectorDialog({super.key});

  @override
  State<GroupSelectorDialog> createState() => _GroupSelectorDialogState();
}

class _GroupSelectorDialogState extends State<GroupSelectorDialog> {
  Group? selectedGroup;

  void updateGroup(Group? newGroup) {
    selectedGroup = newGroup;
  }

  void onConfirm() {
    NavigationService.pop(selectedGroup);
  }

  void onCancel() {
    NavigationService.pop();
  }

  @override
  Widget build(BuildContext context) {
    final groups = BlocProvider.of<GroupsBloc>(context).state.groups;

    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GroupSelector(
            groups: groups,
            onSelected: updateGroup,
          ),
          const SizedBox(
            height: AppMeasures.space,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              ButtonPrimary(
                  onPressed: onConfirm, text: localizations.confirmLabel),
              TextButton(
                  onPressed: onCancel, child: Text(localizations.cancelLabel))
            ],
          ),
        ],
      ),
    );
  }
}
