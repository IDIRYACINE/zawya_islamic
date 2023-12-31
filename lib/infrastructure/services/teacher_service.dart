import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/teacher_service_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_tables_port.dart';

class TeacherService implements TeacherServicePort {
  final DatabasePort _databaseService;

  TeacherService(this._databaseService);

  @override
  Future<DeleteTeacherResponse> deleteTeacher(
      DeleteTeacherOptions options) async {
    final dbOptions = DeleteEntityOptions(metadata: {
      OptionsMetadata.rootCollection: DatabaseCollection.users.name
    }, entries: {
      TeacherTable.userId.name: options.teacherId.value,
    });
    _databaseService.delete(dbOptions);

    return DeleteTeacherResponse(data: null);
  }

  @override
  Future<LoadTeacherResponse> getTeacher(LoadTeacherOptions options) async {
    final dbOptions = ReadEntityOptions(metadata: {
      OptionsMetadata.rootCollection:
          _generateTeacherCollectionCode(options.schoolId.value),
      OptionsMetadata.lastId: options.teacherId.value,
      OptionsMetadata.hasMany: false,
    }, filters: {
      UserTable.userRole.name: UserRoles.teacher.index
    }, mapper: Teacher.fromMap);

    final response = await _databaseService.read(dbOptions);

    return LoadTeacherResponse(data: response.data.first);
  }

  @override
  Future<LoadTeachersResponse> getTeachers(LoadTeachersOptions options) async {
    final metadata = {
      OptionsMetadata.rootCollection:
          _generateTeacherCollectionCode(options.schoolId.value),
      OptionsMetadata.lastId: options.schoolId.value,
      OptionsMetadata.hasMany: true,
    };

    final filters = {
      UserTable.userRole.name: UserRoles.teacher.index,
      UserTable.schoolId.name: options.schoolId.value
    };

    final dbOptions = ReadEntityOptions(
        metadata: metadata, filters: filters, mapper: Teacher.fromMap);

    final response = await _databaseService.read<Teacher>(dbOptions);

    return LoadTeachersResponse(data: response.data);
  }

  @override
  Future<LoadTeacherIdsResponse> loadTeacherIds() {
    throw UnimplementedError();
  }

  @override
  Future<RegisterTeacherResponse> registerTeacher(
      RegisterTeacherOptions options) async {
    final dbOptions = CreateEntityOptions(options.teacher.toMap(), {
      OptionsMetadata.rootCollection:
          _generateTeacherCollectionCode(options.schoolId.value),
      OptionsMetadata.lastId: options.teacher.id.value,
    });

    await _databaseService.create(dbOptions);

    return RegisterTeacherResponse(data: null);
  }

  @override
  Future<UpdateTeacherResponse> updateTeacher(
      UpdateTeacherOptions options) async {
    final dbOptions =
        UpdateEntityOptions(entity: options.teacher.toMap(), metadata: {
      OptionsMetadata.rootCollection:
          _generateTeacherCollectionCode(options.schoolId.value),
      OptionsMetadata.lastId: options.teacher.id.value,
    }, filters: {
      TeacherTable.userId.name: options.teacher.id.value
    });

    await _databaseService.update(dbOptions);

    return UpdateTeacherResponse(data: null);
  }

  String _generateTeacherCollectionCode(String schoolId) {
    // return "${DatabaseCollection.teachers.code}-$schoolId";
    return DatabaseCollection.users.name;
  }
}
