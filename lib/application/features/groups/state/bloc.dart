import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';

import 'events.dart';
import 'state.dart';

class GroupsBloc extends Bloc<GroupEvent, GroupsState> {
  final GroupsAggregate _aggregate = GroupsAggregate([]);

  GroupsBloc() : super(GroupsState.initialState()) {
    on<CreateGroupEvent>(_handleCreateGroup);
    on<UpdateGroupEvent>(_handleUpdateGroup);
    on<DeleteGroupEvent>(_handleDeleteGroup);
    on<LoadGroupsEvent>(_handleLoadGroups);
    on<SetSchoolEvent>(_handleSetSchool);
  }

  FutureOr<void> _handleCreateGroup(
      CreateGroupEvent event, Emitter<GroupsState> emit) {
    final updatedGroups = _aggregate.addGroup(event.group);
    emit(state.copyWith(groups: updatedGroups));
  }

  FutureOr<void> _handleUpdateGroup(
      UpdateGroupEvent event, Emitter<GroupsState> emit) {
    final updatedGroups = _aggregate.updateGroup(event.group);
    emit(state.copyWith(groups: updatedGroups));
  }

  FutureOr<void> _handleLoadGroups(
      LoadGroupsEvent event, Emitter<GroupsState> emit) {
    final updatedGroups = _aggregate.setGroups(event.groups);
    emit(state.copyWith(groups: updatedGroups));
  }

  FutureOr<void> _handleDeleteGroup(
      DeleteGroupEvent event, Emitter<GroupsState> emit) {
    final updatedGroups = _aggregate.deleteGroup(event.group);
    emit(state.copyWith(groups: updatedGroups));
  }

  FutureOr<void> _handleSetSchool(
      SetSchoolEvent event, Emitter<GroupsState> emit) {
    emit(state.copyWith(school: event.school));
  }
}
