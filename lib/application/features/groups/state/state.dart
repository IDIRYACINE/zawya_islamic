import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';

class GroupsState {
  GroupsState({required this.groups});

  final List<Group> groups ;

  factory GroupsState.initialState() {
    return GroupsState(groups: [], );
  }

  GroupsState copyWith({ List<Group>? groups, School? school}) {
    return GroupsState(
      groups: groups ?? this.groups,
    );
  }
}
