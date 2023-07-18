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
    final updatedGroups = event.isPrimary? _aggregate.updateGroup(event.group):
    _aggregate.updateGroup(event.group,state.secondaryGroups)
    ;

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
}
