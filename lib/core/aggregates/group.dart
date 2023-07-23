import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/types.dart';
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

  Map<String, dynamic> toMapWithSchoolId(String schoolId) {
    return {
      GroupsTable.groupId.name: id.value,
      GroupsTable.groupName.name: name.value,
      GroupsTable.schoolId.name: schoolId
    };
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

class WeekDaySchedulesAggregate {
  final WeekDaySchedules _schedules;

  WeekDaySchedulesAggregate(this._schedules);

  factory WeekDaySchedulesAggregate.initail() {
    return WeekDaySchedulesAggregate(List.filled(7, []));
  }

  WeekDaySchedules addEntry(
      {required GroupScheduleEntry entry,
      required int dayIndex,
      List<GroupScheduleEntry>? origin}) {
    final List<GroupScheduleEntry> targetList = origin ?? _schedules[dayIndex];

    targetList.add(entry);

    _schedules[dayIndex] = targetList;
    return _schedules;
  }

  WeekDaySchedules updateEntry(
      {required GroupScheduleEntry entry,
      required GroupScheduleEntry old,
      required int dayIndex,
      List<GroupScheduleEntry>? origin}) {
    final List<GroupScheduleEntry> targetList = origin ?? _schedules[dayIndex];

    final index = targetList.indexWhere((element) => element.equals(old));
    if (index != -1) {
      targetList[index] = entry;
    }
    _schedules[dayIndex] = targetList;
    return _schedules;
  }

  WeekDaySchedules deleteEntry(
      {required GroupScheduleEntry entry,
      required int dayIndex,
      List<GroupScheduleEntry>? origin}) {
    final List<GroupScheduleEntry> targetList = origin ?? _schedules[dayIndex];

    targetList.removeWhere((element) => element.equals(entry));

    _schedules[dayIndex] = targetList;
    return _schedules;
  }

  WeekDaySchedules setEntries(
      {required List<GroupScheduleEntry> schedules,
      required int dayIndex,
      List<GroupScheduleEntry>? origin}) {
    final List<GroupScheduleEntry> targetList = origin ?? _schedules[dayIndex];

    targetList.clear();
    targetList.addAll(schedules);

    _schedules[dayIndex] = targetList;
    return _schedules;
  }

  WeekDaySchedules setSchedules(
      {required WeekDaySchedules schedules, WeekDaySchedules? origin}) {
    final WeekDaySchedules targetList = origin ?? _schedules;

    targetList.clear();
    targetList.addAll(schedules);
    return targetList;
  }

  WeekDaySchedules get schedules => _schedules;
}
