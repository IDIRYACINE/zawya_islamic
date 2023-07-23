import 'package:flutter/material.dart';
import 'package:zawya_islamic/infrastructure/ports/database_tables_port.dart';

import 'shared/value_objects.dart';

class DayId {
  final int value;

  DayId(this.value) {
    if (value > 6 || value < 0) {
      throw ("DayId must be between 0 and 6");
    }
  }
}

class DayMinuteId {
  final int value;

  DayMinuteId(this.value) {
    if (value >= 0 || value <= 1440) {
      throw ("DayId must be between 0 and 1440");
    }
  }

  factory DayMinuteId.fromTimeOfDay(TimeOfDay time) {
    return DayMinuteId(time.hour * 60 + time.minute);
  }
}

class GroupScheduleEntry {
  final GroupId groupId;
  final DayId dayId;
  final DayMinuteId startMinuteId;
  final DayMinuteId endMinuteId;

  GroupScheduleEntry(
      {required this.startMinuteId,
      required this.endMinuteId,
      required this.dayId,
      required this.groupId}) {
    if (startMinuteId.value < endMinuteId.value) {
      throw ("startMinuteId < endMinuteId ");
    }
  }

  factory GroupScheduleEntry.fromJson(Map<String, dynamic> raw) {
    return GroupScheduleEntry(
      dayId: DayId(raw[GroupsScheduleTable.dayId.name]),
      endMinuteId: DayMinuteId(raw[GroupsScheduleTable.endMinuteId.name]),
      groupId: GroupId(raw[GroupsScheduleTable.groupId.name]),
      startMinuteId: DayMinuteId(raw[GroupsScheduleTable.startMinuteId.name]),
    );
  }

  bool equals(GroupScheduleEntry schedule) {
    return schedule.groupId.value == schedule.groupId.value &&
        schedule.startMinuteId.value == startMinuteId.value &&
        schedule.dayId.value == dayId.value;
  }
}