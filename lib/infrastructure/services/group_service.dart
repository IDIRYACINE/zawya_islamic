import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';

class GroupService implements GroupServicePort {
  final DatabasePort _databaseService;

  GroupService(this._databaseService);

  @override
  Future<DeleteGroupResponse> deleteGroup(DeleteGroupOptions options) async {
    final dbOptions = DeleteEntityOptions({
      OptionsMetadata.path: DatabaseCollection.groups.name,
      OptionsMetadata.id: options.groupId.groupId
    });

    _databaseService.delete(dbOptions);

    return DeleteGroupResponse(data: null);
  }

  @override
  Future<LoadGroupResponse> getGroup(LoadGroupOptions options) async {
    final dbOptions = ReadEntityOptions({
      OptionsMetadata.path: DatabaseCollection.groups.name,
      OptionsMetadata.id: options.groupId.groupId,
      OptionsMetadata.hasMany: false,
    }, Group.fromMap);

    final response = await _databaseService.read(dbOptions);

    return LoadGroupResponse(data: response.data.first);
  }

  @override
  Future<TeacherGroupsResponse> getTeacherGroups(LoadGroupsOptions options) {
    // TODO: implement getTeacherGroups
    throw UnimplementedError();
  }

  @override
  Future<LoadGroupIdsResponse> loadGroupIds() {
    // TODO: implement loadGroupIds
    throw UnimplementedError();
  }

  @override
  Future<LoadGroupsResponse> loadGroups(LoadGroupOptions options) {
    // TODO: implement loadGroups
    throw UnimplementedError();
  }

  @override
  Future<RegisterGroupResponse> registerGroup(RegisterGroupOptions options) {
    // TODO: implement registerGroup
    throw UnimplementedError();
  }

  @override
  Future<UpdateGroupResponse> updateGroup(UpdateGroupOptions options) {
    // TODO: implement updateGroup
    throw UnimplementedError();
  }
}
