import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/infrastructure/ports/database_tables_port.dart';

class Group {
  final GroupId id;

  final Name name;

  Group({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      GroupsTable.groupId.name: id.value,
      GroupsTable.groupName.name: name.value,
    };
  }

  factory Group.fromMap(Map<String, dynamic> json) {
    return Group(
      id: GroupId(json[GroupsTable.groupId.name]),
      name: Name(json[GroupsTable.groupName.name]),
    );
  }

  bool equals(Group group, [List<Group>? origin]) {
    return id.equals(group.id);
  }

  Group copyWith({Name? name}) {
    return Group(id: id, name: name ?? this.name);
  }
}

class GroupsAggregate {
  final List<Group> _groups;

  GroupsAggregate(this._groups);

  List<Group> addGroup(Group group, [List<Group>? origin]) {
    final List<Group> targetList = origin ?? _groups;

    targetList.add(group);
    return targetList;
  }

  List<Group> updateGroup(Group group, [List<Group>? origin]) {
    final List<Group> targetList = origin ?? _groups;

    final index = targetList.indexWhere((element) => element.equals(group));
    if (index != -1) {
      targetList[index] = group;
    }
    return targetList;
  }

  List<Group> deleteGroup(Group group, [List<Group>? origin]) {
    final List<Group> targetList = origin ?? _groups;

    targetList.removeWhere((element) => element.equals(group));

    return targetList;
  }

  List<Group> setGroups(List<Group> group, [List<Group>? origin]) {
    final List<Group> targetList = origin ?? _groups;

    targetList.clear();
    targetList.addAll(group);
    return targetList;
  }

  List<Group> get group => _groups;
}
