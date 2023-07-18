import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';

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

class SetSchoolEvent extends GroupEvent {
  final School school;
  SetSchoolEvent({required this.school});
}
