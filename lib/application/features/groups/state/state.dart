import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';

class GroupsState {
  GroupsState({required this.secondaryGroups, required this.groups});

  final List<Group> groups;
  final List<Group> secondaryGroups;

  factory GroupsState.initialState() {
    return GroupsState(
      groups: [],
      secondaryGroups: [],
    );
  }

  GroupsState copyWith(
      {List<Group>? groups, School? school, List<Group>? secondaryGroups}) {
    return GroupsState(
        groups: groups ?? this.groups,
        secondaryGroups: secondaryGroups ?? this.secondaryGroups);
  }
}
