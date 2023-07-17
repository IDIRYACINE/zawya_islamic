import 'package:flutter/material.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/ports/types.dart';

class GroupSelector extends StatefulWidget {
  const GroupSelector(
      {super.key, required this.groups, required this.onSelected,  this.validator});

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
        items: buildItems(), onChanged: widget.onSelected);
  }
}
