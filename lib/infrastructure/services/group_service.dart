import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/infrastructure/helpers/supabase/supabase_app.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_tables_port.dart';

class GroupService implements GroupServicePort {
  final DatabasePort _databaseService;
  final SupabaseApp _supabaseApp = SupabaseApp();

  GroupService(this._databaseService);

  @override
  Future<DeleteGroupResponse> deleteGroup(DeleteGroupOptions options) async {
    final dbOptions = DeleteEntityOptions(metadata: {
      OptionsMetadata.rootCollection: DatabaseCollection.groups
    }, entries: {
      GroupsTable.groupId.name: options.groupId.value,
      GroupsTable.schoolId.name: options.schoolId.value
    });

    _databaseService.delete(dbOptions);

    return DeleteGroupResponse(data: null);
  }

  @override
  Future<LoadGroupResponse> getGroup(LoadGroupOptions options) async {
    final dbOptions = ReadEntityOptions(metadata: {
      OptionsMetadata.rootCollection:
          _generateGroupCode(options.schoolId.value),
      OptionsMetadata.lastId: options.groupId.value,
      OptionsMetadata.hasMany: false,
    }, mapper: Group.fromMap);

    final response = await _databaseService.read(dbOptions);

    return LoadGroupResponse(data: response.data.first);
  }

  @override
  Future<TeacherGroupsResponse> getTeacherGroups(
      LoadTeacherGroupsOptions options) async {
    final List<dynamic> rawData = await _supabaseApp.supabase.client
        .from(DatabaseCollection.userGroups.name)
        .select("""
          ${UserGroupsTable.groupId.name},
          ${DatabaseCollection.groups.name}(
            ${GroupsTable.groupName.name}
          )
          """).eq(UserGroupsTable.userId.name, options.teacherId!.value);

    final List<Group> data = rawData.map((e) {
      e[GroupsTable.groupName.name] = e["groups"][GroupsTable.groupName.name];
      return Group.fromMap(e);
    }).toList();


    return TeacherGroupsResponse(data: data);
  }

  @override
  Future<LoadGroupIdsResponse> loadGroupIds() {
    throw UnimplementedError();
  }

  @override
  Future<LoadGroupsResponse> loadGroups(LoadGroupsOptions options) async {
    final dbOptions = ReadEntityOptions(metadata: {
      OptionsMetadata.rootCollection:
          _generateGroupCode(options.schoolId.value),
      OptionsMetadata.hasMany: true,
    }, mapper: Group.fromMap);

    final response = await _databaseService.read<Group>(dbOptions);

    return LoadGroupsResponse(data: response.data);
  }

  @override
  Future<RegisterGroupResponse> registerGroup(
      RegisterGroupOptions options) async {
    final dbOptions = CreateEntityOptions(options.group.toMap(), {
      OptionsMetadata.rootCollection:
          _generateGroupCode(options.schoolId.value),
      OptionsMetadata.lastId: options.group.id.value,
    });

    await _databaseService.create(dbOptions);

    return RegisterGroupResponse(data: null);
  }

  @override
  Future<RegisterUserGroupResponse> registerUserGroup(
      RegisterUserGroupOptions options) async {
    final dbOptions = CreateEntityOptions(options.userGroup.toMap(), {
      OptionsMetadata.rootCollection: DatabaseCollection.userGroups.name,
    });

    await _databaseService.create(dbOptions);

    return RegisterGroupResponse(data: null);
  }

  @override
  Future<UpdateGroupResponse> updateGroup(UpdateGroupOptions options) async {
    final dbOptions =
        UpdateEntityOptions(entity: options.group.toMap(), metadata: {
      OptionsMetadata.rootCollection:
          _generateGroupCode(options.schoolId.value),
      OptionsMetadata.lastId: options.group.id.value,
    }, filters: {
      GroupsTable.groupId.name: options.group.id.value,
    });

    await _databaseService.update(dbOptions);

    return UpdateGroupResponse(data: null);
  }

  @override
  Future<DeleteUserGroupResponse> deleteUserGroup(
      DeleteUserGroupOptions options) async {
    final dbOptions = DeleteEntityOptions(metadata: {
      OptionsMetadata.rootCollection: DatabaseCollection.userGroups
    }, entries: {
      UserGroupsTable.groupId.name: options.userGroup.groupId.value,
      UserGroupsTable.userId.name: options.userGroup.userId.value
    });

    _databaseService.delete(dbOptions);

    return DeleteGroupResponse(data: null);
  }

  String _generateGroupCode(String schoolId) {
    return DatabaseCollection.groups.name;
  }
}
