import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/ports/types.dart';

class GroupsState {
  GroupsState(
      {required this.groupScheduleEntry,
      required this.secondaryGroups,
      required this.groups});

  final List<Group> groups;
  final List<Group> secondaryGroups;
  final WeekDaySchedules groupScheduleEntry;

  factory GroupsState.initialState() {
    return GroupsState(
      groups: [],
      secondaryGroups: [],
      groupScheduleEntry: List.filled(7, []),
    );
  }

  GroupsState copyWith(
      {List<Group>? groups,
      School? school,
      WeekDaySchedules? groupScheduleEntry,
      List<Group>? secondaryGroups}) {
    return GroupsState(
        groupScheduleEntry: groupScheduleEntry ?? this.groupScheduleEntry,
        groups: groups ?? this.groups,
        secondaryGroups: secondaryGroups ?? this.secondaryGroups);
  }
}
