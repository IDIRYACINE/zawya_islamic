import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_tables_port.dart';

class GroupService implements GroupServicePort {
  final DatabasePort _databaseService;

  GroupService(this._databaseService);

  @override
  Future<DeleteGroupResponse> deleteGroup(DeleteGroupOptions options) async {
    final dbOptions = DeleteEntityOptions(metadata: {
      OptionsMetadata.rootCollection: DatabaseCollection.groups.name
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
    final dbOptions = ReadEntityOptions(
        metadata: {
          OptionsMetadata.rootCollection: DatabaseViews.teacherGroups.name,
          OptionsMetadata.hasMany: true,
        },
        mapper: Group.fromMap,
        filters: {UserGroupsTable.userId.name: options.teacherId!.value});

    final response = await _databaseService.read<Group>(dbOptions);

    return LoadGroupsResponse(data: response.data);
  }

  @override
  Future<LoadGroupIdsResponse> loadGroupIds() {
    throw UnimplementedError();
  }

  @override
  Future<LoadGroupsResponse> loadGroups(LoadGroupsOptions options) async {
    final dbOptions = ReadEntityOptions(
        metadata: {
          OptionsMetadata.rootCollection:
              _generateGroupCode(options.schoolId.value),
          OptionsMetadata.hasMany: true,
        },
        mapper: Group.fromMap,
        filters: {GroupsTable.schoolId.name: options.schoolId.value});

    final response = await _databaseService.read<Group>(dbOptions);

    return LoadGroupsResponse(data: response.data);
  }

  @override
  Future<RegisterGroupResponse> registerGroup(
      RegisterGroupOptions options) async {
    final entity = options.group.toMapWithSchoolId(options.schoolId.value);

    final dbOptions = CreateEntityOptions(entity, {
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

        final entries = {
      UserGroupsTable.groupId.name: options.userGroup.groupId.value,
      UserGroupsTable.userId.name: options.userGroup.userId.value
    };


    final dbOptions = DeleteEntityOptions(metadata: {
      OptionsMetadata.rootCollection: DatabaseCollection.userGroups.name
    }, entries: entries);

    _databaseService.delete(dbOptions);

    return DeleteGroupResponse(data: null);
  }

  String _generateGroupCode(String schoolId) {
    return DatabaseCollection.groups.name;
  }

  @override
  Future<AddScheduleEntryResponse> addGroupScheduleEntry(
      AddScheduleEntryOptions options) async {
    final entity = options.entry.toMap();

    final dbOptions = CreateEntityOptions(entity, {
      OptionsMetadata.rootCollection: DatabaseCollection.groupSchedules.name,
      OptionsMetadata.lastId: null,
    });

    await _databaseService.create(dbOptions);

    return RegisterGroupResponse(data: null);
  }

  @override
  Future<DeleteScheduleEntryResponse> deleteGroupScheduleEntry(
      DeleteScheduleEntryOptions options) async {
    final dbOptions = DeleteEntityOptions(metadata: {
      OptionsMetadata.rootCollection: DatabaseCollection.groupSchedules.name
    }, entries: {
      GroupsScheduleTable.groupId.name: options.entry.groupId.value,
      GroupsScheduleTable.dayId.name: options.entry.dayId.value,
      GroupsScheduleTable.startMinuteId.name: options.entry.startMinuteId.value,
    });

    _databaseService.delete(dbOptions);

    return DeleteGroupResponse(data: null);
  }

  @override
  Future<LoadGroupScheduleResponse> loadGroupSchedule(
      LoadGroupScheduleOptions options) async {
    final dbOptions = ReadEntityOptions(
        metadata: {
          OptionsMetadata.rootCollection:
              DatabaseCollection.groupScheduleOrderd.name,
          OptionsMetadata.hasMany: true,
        },
        mapper: GroupScheduleEntry.fromMap,
        filters: {GroupsScheduleTable.groupId.name: options.groupId.value});

    final response = await _databaseService.read<GroupScheduleEntry>(dbOptions);

    final List<List<GroupScheduleEntry>> schedule =
        _generateGroupScheduleByDays(response.data);

    return LoadGroupScheduleResponse(data: schedule);
  }

  List<List<GroupScheduleEntry>> _generateGroupScheduleByDays(
      List<GroupScheduleEntry> data) {
    final List<List<GroupScheduleEntry>> result = [[], [], [], [], [], [], []];

    for (GroupScheduleEntry element in data) {
      result[element.dayId.value].add(element);
    }

    return result;
  }

  @override
  Future<UpdateGroupScheduleEntryResponse> updateScheduleEntry(
      UpdateScheduleEntryOptions options) async {
    final dbOptions = UpdateEntityOptions(
        entity: options.updated.toMap(updatedMode: true),
        metadata: {
          OptionsMetadata.rootCollection:
              DatabaseCollection.groupSchedules.name,
          OptionsMetadata.lastId: null,
        },
        filters: {
          GroupsScheduleTable.groupId.name: options.old.groupId.value,
          GroupsScheduleTable.dayId.name: options.old.dayId.value,
          GroupsScheduleTable.startMinuteId.name:
              options.old.startMinuteId.value,
        });

    await _databaseService.update(dbOptions);

    return UpdateGroupResponse(data: null);
  }
}
