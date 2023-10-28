import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/entities/group_statistiques.dart';
import 'package:zawya_islamic/core/ports/types.dart';

class GroupsState {
  GroupsState(
      {required this.groupScheduleEntry,
      required this.selectedDayIndex,
      required this.secondaryGroups,
      required this.statistiques,
      required this.search,
      this.selectedGroup,
      required this.groups});

  final List<Group> groups;
  final List<Group> secondaryGroups;
  final List<GroupStatistiques> statistiques;
  final WeekDaySchedules groupScheduleEntry;
  final List<GroupStatistiques> search;
  final Group? selectedGroup;
  final int selectedDayIndex;

  factory GroupsState.initialState() {
    return GroupsState(
      search: [],
      selectedDayIndex: 0,
      groups: [],
      secondaryGroups: [],
      groupScheduleEntry: [[], [], [], [], [], [], []],
      statistiques: [],
    );
  }

  List<GroupScheduleEntry> get daySchedule =>
      groupScheduleEntry[selectedDayIndex];

  List<GroupScheduleEntry> get weekSchedule {
    List<GroupScheduleEntry> weekSchedule = [];
    for (var daySchedule in groupScheduleEntry) {
      weekSchedule.addAll(daySchedule);
    }
    return weekSchedule;
  }

  GroupsState copyWith(
      {List<Group>? groups,
      School? school,
      Group? selectedGroup,
      int? selectedDayIndex,
      bool nullifySelectedGroup = false,
      WeekDaySchedules? groupScheduleEntry,
      List<GroupStatistiques>? search,
      List<GroupStatistiques>? statistiques,
      List<Group>? secondaryGroups}) {
    return GroupsState(
        selectedDayIndex: selectedDayIndex ?? this.selectedDayIndex,
        groupScheduleEntry: groupScheduleEntry ?? this.groupScheduleEntry,
        groups: groups ?? this.groups,
        selectedGroup:
            nullifySelectedGroup ? null : selectedGroup ?? this.selectedGroup,
        secondaryGroups: secondaryGroups ?? this.secondaryGroups,
        search: search ?? this.search,
        statistiques: statistiques ?? this.statistiques);
  }
}
