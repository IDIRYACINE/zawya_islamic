import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';

class GroupsState {
  GroupsState({required this.groups ,required this.school});

  final List<Group> groups ;
  final School school;

  factory GroupsState.initialState() {
    return GroupsState(groups: [], school: School.empty());
  }

  GroupsState copyWith({ List<Group>? groups, School? school}) {
    return GroupsState(
      groups: groups ?? this.groups,
      school: school ?? this.school,
    );
  }
}
