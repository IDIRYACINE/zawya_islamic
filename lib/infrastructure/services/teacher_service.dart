

import 'package:zawya_islamic/core/ports/teacher_service_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';

class TeacherService implements TeacherServicePort{
    final DatabasePort _databaseService;

  TeacherService(this._databaseService);

  @override
  Future<DeleteTeacherResponse> deleteTeacher(DeleteTeacherOptions options) {
    // TODO: implement deleteTeacher
    throw UnimplementedError();
  }

  @override
  Future<LoadTeacherResponse> getTeacher(LoadTeacherOptions options) {
    // TODO: implement getTeacher
    throw UnimplementedError();
  }

  @override
  Future<LoadTeachersResponse> getTeachers(LoadTeachersOptions options) {
    // TODO: implement getTeachers
    throw UnimplementedError();
  }

  @override
  Future<LoadTeacherIdsResponse> loadTeacherIds() {
    // TODO: implement loadTeacherIds
    throw UnimplementedError();
  }

  @override
  Future<RegisterTeacherResponse> registerTeacher(RegisterTeacherOptions options) {
    // TODO: implement registerTeacher
    throw UnimplementedError();
  }

  @override
  Future<UpdateTeacherResponse> updateTeacher(UpdateTeacherOptions options) {
    // TODO: implement updateTeacher
    throw UnimplementedError();
  }
}