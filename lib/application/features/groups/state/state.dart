import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/types.dart';

class GroupsState {
  GroupsState(
      {required this.groupScheduleEntry,
      required this.selectedDayIndex,
      required this.secondaryGroups,
      this.selectedGroup,
      required this.groups});

  final List<Group> groups;
  final List<Group> secondaryGroups;
  final WeekDaySchedules groupScheduleEntry;
  final Group? selectedGroup;
  final int selectedDayIndex;

  factory GroupsState.initialState() {
    return GroupsState(
      selectedDayIndex: 0,
      groups: [],
      secondaryGroups: [],
      groupScheduleEntry: [[],[],[],[],[],[],[]],
    );
  }

  List<GroupScheduleEntry> get daySchedule => groupScheduleEntry[selectedDayIndex];

  GroupsState copyWith(
      {List<Group>? groups,
      School? school,
      Group? selectedGroup,
      int? selectedDayIndex,
      bool nullifySelectedGroup = false,
      WeekDaySchedules? groupScheduleEntry,
      List<Group>? secondaryGroups}) {
    return GroupsState(
        selectedDayIndex: selectedDayIndex ?? this.selectedDayIndex,
        groupScheduleEntry: groupScheduleEntry ?? this.groupScheduleEntry,
        groups: groups ?? this.groups,
        selectedGroup:
            nullifySelectedGroup ? null : selectedGroup ?? this.selectedGroup,
        secondaryGroups: secondaryGroups ?? this.secondaryGroups);
  }
}
