import 'package:zawya_islamic/core/entities/export.dart';

enum GroupAttributes {
  id,
  name,
}

class Group {
  final GroupId id;

  final Name name;

  Group({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      GroupAttributes.id.name: id.groupId,
      GroupAttributes.name.name: name.value,
    };
  }

  factory Group.fromMap(Map<String, dynamic> json) {
    return Group(
      id: GroupId(json['id']),
      name: Name(json['name']),
    );
  }

  bool equals(Group group) {
    return id.equals(group.id);
  }

  Group copyWith({Name? name}) {
    return Group(id: id, name: name ?? this.name);
  }
}

class GroupsAggregate {
  final List<Group> _groups;

  GroupsAggregate(this._groups);

  List<Group> addGroup(Group group) {
    _groups.add(group);
    return _groups;
  }

  List<Group> updateGroup(Group group) {
    final index = _groups.indexWhere((element) => element.equals(group));
    if (index != -1) {
      _groups[index] = group;
    }
    return _groups;
  }

  List<Group> deleteGroup(Group group) {
    _groups.removeWhere((element) => element.equals(group));

    return _groups;
  }

  List<Group> setGroups(List<Group> group) {
    _groups.clear();
    _groups.addAll(group);
    return _groups;
  }

  List<Group> get group => _groups;
}
