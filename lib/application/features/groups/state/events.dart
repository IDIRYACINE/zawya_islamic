import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/entities/group_statistiques.dart';
import 'package:zawya_islamic/core/ports/types.dart';

abstract class GroupEvent {}

class CreateGroupEvent extends GroupEvent {
  final Group group;
  final bool isPrimary;
  CreateGroupEvent({this.isPrimary = true, required this.group});
}

class UpdateGroupEvent extends GroupEvent {
  final Group group;
  final bool isPrimary;

  UpdateGroupEvent({this.isPrimary = true, required this.group});
}

class DeleteGroupEvent extends GroupEvent {
  final Group group;
  final bool isPrimary;
  DeleteGroupEvent({this.isPrimary = true, required this.group});
}

class LoadGroupsEvent extends GroupEvent {
  final List<Group> groups;
  final bool isPrimary;
  LoadGroupsEvent({this.isPrimary = true, required this.groups});
}

class LoadGroupStatistiquesEvent extends GroupEvent {
  final List<GroupStatistiques> statistiques;
  LoadGroupStatistiquesEvent({required this.statistiques});
}

class LoadGroupSearchEvent extends GroupEvent {
  final List<GroupStatistiques> groups;
  LoadGroupSearchEvent({required this.groups});
}

class SetSchoolEvent extends GroupEvent {
  final School school;
  SetSchoolEvent({required this.school});
}

class SetWeekDaySchedulesEvent extends GroupEvent {
  final WeekDaySchedules schedules;

  SetWeekDaySchedulesEvent({required this.schedules});
}

class AddDayScheduleEntryEvent extends GroupEvent {
  final int dayIndex;
  final GroupScheduleEntry entry;

  AddDayScheduleEntryEvent({required this.dayIndex, required this.entry});
}

class SelectGroupEvent extends GroupEvent {
  final Group? group;

  SelectGroupEvent({this.group});
}

class UpdateDayScheduleEntryEvent extends GroupEvent {
  final int dayIndex;
  final GroupScheduleEntry entry;
  final GroupScheduleEntry old;

  UpdateDayScheduleEntryEvent(
      {required this.old, required this.dayIndex, required this.entry});
}

class DeleteDayScheduleEntryEvent extends GroupEvent {
  final int dayIndex;
  final GroupScheduleEntry entry;

  DeleteDayScheduleEntryEvent({required this.dayIndex, required this.entry});
}

class SelectDayIndexEvent extends GroupEvent {
  final int dayIndex;

  SelectDayIndexEvent({required this.dayIndex});
}
