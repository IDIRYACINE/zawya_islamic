import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/entities/export.dart';

typedef TeacherGroupsResponse = GroupServiceResponse<List<GroupId>>;
typedef LoadGroupsResponse = GroupServiceResponse<List<Group>>;
typedef LoadGroupResponse = GroupServiceResponse<Group>;
typedef RegisterGroupResponse = GroupServiceResponse<void>;
typedef UpdateGroupResponse = GroupServiceResponse<void>;
typedef DeleteGroupResponse = GroupServiceResponse<void>;
typedef LoadGroupIdsResponse = GroupServiceResponse<List<GroupId>>;

abstract class GroupServiceResponse<T> {
  final String? message;
  final bool success;
  final T data;

  GroupServiceResponse({this.message, this.success = true, required this.data});
}


abstract class GroupServiceOptions {}

class LoadGroupsOptions extends GroupServiceOptions {
  final List<GroupId> groupIds;

  LoadGroupsOptions({this.groupIds = const []});
}

class LoadGroupOptions extends GroupServiceOptions {
  final GroupId groupId;

  LoadGroupOptions({required this.groupId});
}

class RegisterGroupOptions extends GroupServiceOptions {
  final Group group;

  RegisterGroupOptions({required this.group});
}

class UpdateGroupOptions extends GroupServiceOptions {
  final Group group;

  UpdateGroupOptions({required this.group});
}

class DeleteGroupOptions extends GroupServiceOptions {
  final GroupId groupId;

  DeleteGroupOptions({required this.groupId});
}

abstract class GroupServicePort {
  Future<LoadGroupIdsResponse> loadGroupIds();
  Future<TeacherGroupsResponse> getTeacherGroups(LoadGroupsOptions options);
  Future<LoadGroupResponse> getGroup(LoadGroupOptions options);
  Future<LoadGroupsResponse> loadGroups(LoadGroupOptions options);
  Future<RegisterGroupResponse> registerGroup(RegisterGroupOptions options);
  Future<UpdateGroupResponse> updateGroup(UpdateGroupOptions options);
  Future<DeleteGroupResponse> deleteGroup(DeleteGroupOptions options);
}
