import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/entities/relations.dart';

typedef TeacherGroupsResponse = GroupServiceResponse<List<Group>>;
typedef LoadGroupsResponse = GroupServiceResponse<List<Group>>;
typedef LoadGroupResponse = GroupServiceResponse<Group>;
typedef RegisterGroupResponse = GroupServiceResponse<void>;
typedef RegisterUserGroupResponse = GroupServiceResponse<void>;
typedef UpdateGroupResponse = GroupServiceResponse<void>;
typedef DeleteGroupResponse = GroupServiceResponse<void>;
typedef DeleteUserGroupResponse = GroupServiceResponse<void>;
typedef LoadGroupIdsResponse = GroupServiceResponse<List<GroupId>>;

class GroupServiceResponse<T> {
  final String? message;
  final bool success;
  final T data;

  GroupServiceResponse({this.message, this.success = true, required this.data});
}

abstract class GroupServiceOptions {}


class RegisterUserGroupOptions extends GroupServiceOptions{

  final UserGroup userGroup;
 

  RegisterUserGroupOptions({required this.userGroup});
}


class DeleteUserGroupOptions extends GroupServiceOptions{

  final UserGroup userGroup;
 

  DeleteUserGroupOptions({required this.userGroup});
}

class LoadTeacherGroupsOptions extends GroupServiceOptions {
  final List<GroupId> groupIds;
  final SchoolId schoolId;
  final TeacherId? teacherId;

  LoadTeacherGroupsOptions(
      {required this.schoolId,
      required this.teacherId,
      this.groupIds = const []});
}


class LoadGroupsOptions extends GroupServiceOptions {
  final SchoolId schoolId;

  LoadGroupsOptions(
      {required this.schoolId,
      });
}

class LoadGroupOptions extends GroupServiceOptions {
  final GroupId groupId;
  final SchoolId schoolId;

  LoadGroupOptions({required this.groupId, required this.schoolId});
}

class RegisterGroupOptions extends GroupServiceOptions {
  final Group group;
  final SchoolId schoolId;

  RegisterGroupOptions({required this.group,required this.schoolId});
}

class UpdateGroupOptions extends GroupServiceOptions {
  final Group group;
  final SchoolId schoolId;

  UpdateGroupOptions({required this.group,required this.schoolId});
}

class DeleteGroupOptions extends GroupServiceOptions {
  final GroupId groupId;
  final SchoolId schoolId;

  DeleteGroupOptions( {required this.schoolId,required this.groupId});
}

abstract class GroupServicePort {
  Future<LoadGroupIdsResponse> loadGroupIds();
  Future<TeacherGroupsResponse> getTeacherGroups(LoadTeacherGroupsOptions options);
  Future<LoadGroupResponse> getGroup(LoadGroupOptions options);
  Future<LoadGroupsResponse> loadGroups(LoadGroupsOptions options);
  Future<RegisterGroupResponse> registerGroup(RegisterGroupOptions options);
  Future<UpdateGroupResponse> updateGroup(UpdateGroupOptions options);
  Future<DeleteGroupResponse> deleteGroup(DeleteGroupOptions options);

  Future<RegisterUserGroupResponse> registerUserGroup(RegisterUserGroupOptions options) ;

  Future<DeleteUserGroupResponse> deleteUserGroup(DeleteUserGroupOptions options) ;

}
