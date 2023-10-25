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

class Day {
  final DayId id;
  final String name;

  Day({required this.id, required this.name});
}

class DayMinuteId {
  final int value;

  DayMinuteId(this.value) {
    if (value < 0 || value > 1440) {
      throw ("DayId must be between 0 and 1440");
    }
  }

  factory DayMinuteId.fromTimeOfDay(TimeOfDay time) {
    return DayMinuteId(time.hour * 60 + time.minute);
  }

  String toDisplayFormat() {
    final hours = value ~/ 60;
    final minutes = value % 60;

    final hoursStr = hours.toString().padLeft(2, '0');
    final minutesStr = minutes.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr';
  }

  TimeOfDay toTimeOfDay() {
    final hours = value ~/ 60;
    final minutes = value % 60;
    return TimeOfDay(hour: hours, minute: minutes);
  }
}

class Room {
  final String value;

  Room(this.value);
}

class GroupScheduleEntry {
  final GroupId groupId;
  final DayId dayId;
  final DayMinuteId startMinuteId;
  final DayMinuteId endMinuteId;
  final Room room;

  GroupScheduleEntry(
      {required this.startMinuteId,
      required this.endMinuteId,
      required this.dayId,
      required this.room,
      required this.groupId}) {
    if (startMinuteId.value > endMinuteId.value) {
      throw ("startMinuteId < endMinuteId  : ${startMinuteId.value} > ${endMinuteId.value}");
    }
  }

  factory GroupScheduleEntry.fromJson(Map<String, dynamic> raw) {
    return GroupScheduleEntry(
      dayId: DayId(raw[GroupsScheduleTable.dayId.name]),
      endMinuteId: DayMinuteId(raw[GroupsScheduleTable.endMinuteId.name]),
      groupId: GroupId(raw[GroupsScheduleTable.groupId.name]),
      startMinuteId: DayMinuteId(raw[GroupsScheduleTable.startMinuteId.name]),
      room: Room(raw[GroupsScheduleTable.room.name]),
    );
  }

  bool equals(GroupScheduleEntry schedule) {
    return schedule.groupId.value == schedule.groupId.value &&
        schedule.startMinuteId.value == startMinuteId.value &&
        schedule.dayId.value == dayId.value;
  }

  GroupScheduleEntry copyWith(
      {DayMinuteId? startMinuteId, DayMinuteId? endMinuteId, Room? room}) {
    return GroupScheduleEntry(
        dayId: dayId,
        groupId: groupId,
        startMinuteId: startMinuteId ?? this.startMinuteId,
        endMinuteId: endMinuteId ?? this.endMinuteId,
        room: room ?? this.room);
  }

  @override
  String toString() {
    return "${groupId.value}-${dayId.value}-${startMinuteId.value}";
  }

  Map<String, dynamic> toMap({bool updatedMode = false}) {
    if (updatedMode) {
      return {
        GroupsScheduleTable.endMinuteId.name: endMinuteId.value,
        GroupsScheduleTable.startMinuteId.name: startMinuteId.value,
        GroupsScheduleTable.room.name: room.value,
      };
    }
    return {
      GroupsScheduleTable.groupId.name: groupId.value,
      GroupsScheduleTable.dayId.name: dayId.value,
      GroupsScheduleTable.endMinuteId.name: endMinuteId.value,
      GroupsScheduleTable.startMinuteId.name: startMinuteId.value,
      GroupsScheduleTable.room.name: room.value,
    };
  }

  factory GroupScheduleEntry.fromMap(Map<String, dynamic> raw) {
    return GroupScheduleEntry(
      dayId: DayId(raw[GroupsScheduleTable.dayId.name]),
      endMinuteId: DayMinuteId(raw[GroupsScheduleTable.endMinuteId.name]),
      groupId: GroupId(raw[GroupsScheduleTable.groupId.name]),
      startMinuteId: DayMinuteId(
        raw[GroupsScheduleTable.startMinuteId.name],
      ),
      room: Room(raw[GroupsScheduleTable.room.name]),
    );
  }
}
