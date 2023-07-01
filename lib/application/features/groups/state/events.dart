import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';

abstract class GroupEvent {}

class CreateGroupEvent extends GroupEvent {
  final Group group;
  CreateGroupEvent({required this.group});
}


class UpdateGroupEvent extends GroupEvent{
  final Group group;
  UpdateGroupEvent({required this.group});
}

class DeleteGroupEvent extends GroupEvent{
  final Group group;

  DeleteGroupEvent({required this.group});
}

class LoadGroupsEvent extends GroupEvent{
  final List<Group> groups;
  LoadGroupsEvent({required this.groups});
}

class SetSchoolEvent extends GroupEvent {
  final School school;
  SetSchoolEvent({required this.school});
}