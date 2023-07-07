

import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/teacher_service_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';

class TeacherService implements TeacherServicePort{
    final DatabasePort _databaseService;

  TeacherService(this._databaseService);

  @override
  Future<DeleteTeacherResponse> deleteTeacher(DeleteTeacherOptions options) async {
      final dbOptions = DeleteEntityOptions({
      OptionsMetadata.fullPath:
          '${DatabaseCollection.teachers.name}/${options.teacherId}',
    });

    _databaseService.delete(dbOptions);

    return DeleteTeacherResponse(data: null);
  }

  @override
  Future<LoadTeacherResponse> getTeacher(LoadTeacherOptions options) async {
    final dbOptions = ReadEntityOptions({
      OptionsMetadata.path: DatabaseCollection.teachers.name,
      OptionsMetadata.id: options.teacherId.id,
      OptionsMetadata.hasMany: false,
    }, Teacher.fromMap);

    final response = await _databaseService.read(dbOptions);

    return LoadTeacherResponse(data: response.data.first);
  }

  @override
  Future<LoadTeachersResponse> getTeachers(LoadTeachersOptions options) async {
    final dbOptions = ReadEntityOptions({
      OptionsMetadata.path: DatabaseCollection.teachers.name,
      OptionsMetadata.id : options.schoolId.value,
      OptionsMetadata.hasMany: true,
    }, Teacher.fromMap);

    final response = await _databaseService.read<Teacher>(dbOptions);

    return LoadTeachersResponse(data: response.data);
  }

  @override
  Future<LoadTeacherIdsResponse> loadTeacherIds() {
    // TODO: implement loadTeacherIds
    throw UnimplementedError();
  }

  @override
  Future<RegisterTeacherResponse> registerTeacher(RegisterTeacherOptions options) async {
    final dbOptions = CreateEntityOptions(options.teacher.toMap(),{
      OptionsMetadata.path: DatabaseCollection.teachers.name,
      OptionsMetadata.id: options.teacher.id.id,
    });

     await _databaseService.create(dbOptions);

    return RegisterTeacherResponse(data: null);
  }

  @override
  Future<UpdateTeacherResponse> updateTeacher(UpdateTeacherOptions options) async {
    final dbOptions = UpdateEntityOptions(options.teacher.toMap(), {
      OptionsMetadata.fullPath:
          '${DatabaseCollection.teachers.name}/${options.teacher.id.id}',
    });

    await _databaseService.update(dbOptions);

    return UpdateTeacherResponse(data: null);
  }
}