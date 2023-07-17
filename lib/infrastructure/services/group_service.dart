import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';

class GroupService implements GroupServicePort {
  final DatabasePort _databaseService;

  GroupService(this._databaseService);

  @override
  Future<DeleteGroupResponse> deleteGroup(DeleteGroupOptions options) async {
    final dbOptions = DeleteEntityOptions({
      OptionsMetadata.rootCollection:
          _generateGroupCode(options.schoolId.value),
      OptionsMetadata.lastId: options.groupId.groupId
    });

    _databaseService.delete(dbOptions);

    return DeleteGroupResponse(data: null);
  }

  @override
  Future<LoadGroupResponse> getGroup(LoadGroupOptions options) async {
    final dbOptions = ReadEntityOptions({
      OptionsMetadata.rootCollection:
          _generateGroupCode(options.schoolId.value),
      OptionsMetadata.lastId: options.groupId.groupId,
      OptionsMetadata.hasMany: false,
    }, Group.fromMap);

    final response = await _databaseService.read(dbOptions);

    return LoadGroupResponse(data: response.data.first);
  }

  @override
  Future<TeacherGroupsResponse> getTeacherGroups(
      LoadTeacherGroupsOptions options) async {
    final dbOptions = ReadEntityOptions({
      OptionsMetadata.rootCollection: _generateTeacherGroupCode(options.schoolId.value),
      OptionsMetadata.lastId: options.teacherId!.id,
      OptionsMetadata.hasMany: true,
    }, Group.fromMap);

    final response = await _databaseService.read<Group>(dbOptions);

    return TeacherGroupsResponse(data: response.data);
  }

  @override
  Future<LoadGroupIdsResponse> loadGroupIds() {
    throw UnimplementedError();
  }

  @override
  Future<LoadGroupsResponse> loadGroups(LoadGroupsOptions options) async {
    final dbOptions = ReadEntityOptions({
      OptionsMetadata.rootCollection:
          _generateGroupCode(options.schoolId.value),
      OptionsMetadata.hasMany: true,
    }, Group.fromMap);

    final response = await _databaseService.read<Group>(dbOptions);

    return LoadGroupsResponse(data: response.data);
  }

  @override
  Future<RegisterGroupResponse> registerGroup(
      RegisterGroupOptions options) async {
    final dbOptions = CreateEntityOptions(options.group.toMap(), {
      OptionsMetadata.rootCollection:
          _generateGroupCode(options.schoolId.value),
      OptionsMetadata.lastId: options.group.id.groupId,
    });

    await _databaseService.create(dbOptions);

    return RegisterGroupResponse(data: null);
  }

  @override
  Future<UpdateGroupResponse> updateGroup(UpdateGroupOptions options) async {
    final dbOptions = UpdateEntityOptions(options.group.toMap(), {
      OptionsMetadata.rootCollection:
          _generateGroupCode(options.schoolId.value),
      OptionsMetadata.lastId: options.schoolId.value,
    });

    await _databaseService.update(dbOptions);

    return UpdateGroupResponse(data: null);
  }

  String _generateGroupCode(String schoolId) {
    return "${DatabaseCollection.groups.code}-$schoolId";
  }

  String _generateTeacherGroupCode(String schoolId){
        return "${DatabaseCollection.teacherGroups.code}-$schoolId";

  }
}
