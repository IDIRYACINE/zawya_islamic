import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';

import 'events.dart';
import 'state.dart';

class GroupsBloc extends Bloc<GroupEvent, GroupsState> {
  final GroupsAggregate _aggregate = GroupsAggregate([]);
  final WeekDaySchedulesAggregate _scheduleAggregate =
      WeekDaySchedulesAggregate.initail();

  GroupsBloc() : super(GroupsState.initialState()) {
    on<CreateGroupEvent>(_handleCreateGroup);
    on<UpdateGroupEvent>(_handleUpdateGroup);
    on<DeleteGroupEvent>(_handleDeleteGroup);
    on<LoadGroupsEvent>(_handleLoadGroups);
    on<SetSchoolEvent>(_handleSetSchool);
    on<SetWeekDaySchedulesEvent>(_handleSetWeeDaykSchedules);
    on<AddDayScheduleEntryEvent>(_handleAddScheduleEntry);
    on<DeleteDayScheduleEntryEvent>(_handleDeleteScheduleEntry);
    on<UpdateDayScheduleEntryEvent>(_handleUpdateScheduleEntry);
    on<SelectGroupEvent>(_handleSelectGroup);
    on<SelectDayIndexEvent>(_handleSelectDayIndex);
    on<LoadGroupSearchEvent>(_handleLoadGroupSearch);
  }

  FutureOr<void> _handleCreateGroup(
      CreateGroupEvent event, Emitter<GroupsState> emit) {
    final updatedGroups = event.isPrimary
        ? _aggregate.addGroup(event.group)
        : _aggregate.addGroup(event.group, state.secondaryGroups);
    if (event.isPrimary) {
      emit(state.copyWith(groups: updatedGroups));
    } else {
      emit(state.copyWith(secondaryGroups: updatedGroups));
    }
  }

  FutureOr<void> _handleUpdateGroup(
      UpdateGroupEvent event, Emitter<GroupsState> emit) {
    final updatedGroups = event.isPrimary
        ? _aggregate.updateGroup(event.group)
        : _aggregate.updateGroup(event.group, state.secondaryGroups);

    if (event.isPrimary) {
      emit(state.copyWith(groups: updatedGroups));
    } else {
      emit(state.copyWith(secondaryGroups: updatedGroups));
    }
  }

  FutureOr<void> _handleLoadGroups(
      LoadGroupsEvent event, Emitter<GroupsState> emit) {
    final updatedGroups = event.isPrimary
        ? _aggregate.setGroups(event.groups)
        : _aggregate.setGroups(event.groups, state.secondaryGroups);

    if (event.isPrimary) {
      emit(state.copyWith(groups: updatedGroups));
    } else {
      emit(state.copyWith(secondaryGroups: updatedGroups));
    }
  }

  FutureOr<void> _handleDeleteGroup(
      DeleteGroupEvent event, Emitter<GroupsState> emit) {
    final updatedGroups = event.isPrimary
        ? _aggregate.deleteGroup(event.group)
        : _aggregate.deleteGroup(event.group, state.secondaryGroups);

    if (event.isPrimary) {
      emit(state.copyWith(groups: updatedGroups));
    } else {
      emit(state.copyWith(secondaryGroups: updatedGroups));
    }
  }

  FutureOr<void> _handleSetSchool(
      SetSchoolEvent event, Emitter<GroupsState> emit) {
    emit(state.copyWith(school: event.school));
  }

  FutureOr<void> _handleSetWeeDaykSchedules(
      SetWeekDaySchedulesEvent event, Emitter<GroupsState> emit) {
    final updatedSchedules =
        _scheduleAggregate.setSchedules(schedules: event.schedules);

    emit(state.copyWith(groupScheduleEntry: updatedSchedules));
  }

  FutureOr<void> _handleAddScheduleEntry(
      AddDayScheduleEntryEvent event, Emitter<GroupsState> emit) {
    final updatedSchedules = _scheduleAggregate.addEntry(
        entry: event.entry, dayIndex: state.selectedDayIndex);

    emit(state.copyWith(groupScheduleEntry: updatedSchedules));
  }

  FutureOr<void> _handleDeleteScheduleEntry(
      DeleteDayScheduleEntryEvent event, Emitter<GroupsState> emit) {
    final updatedSchedules = _scheduleAggregate.deleteEntry(
        entry: event.entry, dayIndex: event.dayIndex);

    emit(
      state.copyWith(groupScheduleEntry: updatedSchedules),
    );
  }

  FutureOr<void> _handleUpdateScheduleEntry(
      UpdateDayScheduleEntryEvent event, Emitter<GroupsState> emit) {
    final updatedSchedules = _scheduleAggregate.updateEntry(
        entry: event.entry, old: event.old, dayIndex: event.dayIndex);

    emit(
      state.copyWith(groupScheduleEntry: updatedSchedules),
    );
  }

  FutureOr<void> _handleSelectGroup(
      SelectGroupEvent event, Emitter<GroupsState> emit) {
    emit(state.copyWith(
        selectedGroup: event.group, nullifySelectedGroup: event.group == null));
  }

  FutureOr<void> _handleSelectDayIndex(
      SelectDayIndexEvent event, Emitter<GroupsState> emit) {
    emit(state.copyWith(selectedDayIndex: event.dayIndex));
  }

  FutureOr<void> _handleLoadGroupSearch(
      LoadGroupSearchEvent event, Emitter<GroupsState> emit) {
    emit(state.copyWith(search: event.groups));
  }
}
