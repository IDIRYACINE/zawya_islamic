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
      OptionsMetadata.nestedId: options.schoolId.value,
      OptionsMetadata.hasMany: false,
    }, Group.fromMap);

    final response = await _databaseService.read(dbOptions);

    return LoadGroupResponse(data: response.data.first);
  }

  @override
  Future<TeacherGroupsResponse> getTeacherGroups(LoadGroupsOptions options) async{

    final dbOptions = ReadEntityOptions({
      OptionsMetadata.path: DatabaseCollection.teacherGroups.name,
      OptionsMetadata.id: options.schoolId.value,
      OptionsMetadata.nestedId: options.teacherId.id,
      OptionsMetadata.hasMany: true,
    }, Group.fromMap);

    final response = await _databaseService.read<Group>(dbOptions);
    
    return TeacherGroupsResponse(data: response.data);
  }

  @override
  Future<LoadGroupIdsResponse> loadGroupIds() {
    // TODO: implement loadGroupIds
    throw UnimplementedError();
  }

  @override
  Future<LoadGroupsResponse> loadGroups(LoadGroupOptions options) async {
    final dbOptions = ReadEntityOptions({
      OptionsMetadata.path: DatabaseCollection.groups.name,
      OptionsMetadata.id: options.schoolId.value,
      OptionsMetadata.hasMany: true,
    }, Group.fromMap);

    final response = await _databaseService.read<Group>(dbOptions);

    return LoadGroupsResponse(data: response.data);
  }

  @override
  Future<RegisterGroupResponse> registerGroup(RegisterGroupOptions options) async {
    final dbOptions = CreateEntityOptions(
      options.group.toMap()
      ,{
      OptionsMetadata.path: DatabaseCollection.groups.name,
      OptionsMetadata.id: options.group.id.groupId,
      OptionsMetadata.nestedId: options.schoolId.value,
    });

    await _databaseService.create(dbOptions);

    return RegisterGroupResponse(data: null);
  }

  @override
  Future<UpdateGroupResponse> updateGroup(UpdateGroupOptions options) async{
    final dbOptions = UpdateEntityOptions(
      options.group.toMap()
      ,{
      OptionsMetadata.path: DatabaseCollection.groups.name,
      OptionsMetadata.id: options.group.id.groupId,
      OptionsMetadata.nestedId: options.schoolId.value,
    });

    await _databaseService.update(dbOptions);

    return UpdateGroupResponse(data: null);
  }
}
