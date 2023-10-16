


import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';

typedef LoadTeacherIdsResponse = TeacherServiceResponse<List<TeacherId>>;
typedef LoadTeachersResponse = TeacherServiceResponse<List<Teacher>>;
typedef LoadTeacherResponse = TeacherServiceResponse<Teacher>;
typedef RegisterTeacherResponse = TeacherServiceResponse<void>;
typedef UpdateTeacherResponse = TeacherServiceResponse<void>;
typedef DeleteTeacherResponse = TeacherServiceResponse<void>;


class TeacherServiceResponse<T> {
  final String? message;
  final bool success;
  final T data;

  TeacherServiceResponse({this.message, this.success = true, required this.data});
}

abstract class TeacherServiceOptions {}

class LoadTeachersOptions extends TeacherServiceOptions {
  final List<TeacherId> teacherIds;
  final SchoolId schoolId;

  LoadTeachersOptions({this.teacherIds = const [],required this.schoolId,});
}

class LoadTeacherOptions extends TeacherServiceOptions {
  final TeacherId teacherId;
  final SchoolId schoolId;
  
  LoadTeacherOptions({required this.teacherId,required this.schoolId,});
}

class RegisterTeacherOptions extends TeacherServiceOptions {
  final Teacher teacher;
  final SchoolId schoolId;

  RegisterTeacherOptions({required this.teacher,required this.schoolId,});
}

class UpdateTeacherOptions extends TeacherServiceOptions {
  final Teacher teacher;
  final SchoolId schoolId;

  UpdateTeacherOptions({required this.teacher, required this.schoolId,});
}

class DeleteTeacherOptions extends TeacherServiceOptions {
  final TeacherId teacherId;
  final SchoolId schoolId;

  DeleteTeacherOptions( {required this.teacherId,required this.schoolId,});
}

abstract class TeacherServicePort {
  Future<LoadTeacherIdsResponse> loadTeacherIds();
  Future<LoadTeacherResponse> getTeacher(LoadTeacherOptions options);
  Future<LoadTeachersResponse> getTeachers(LoadTeachersOptions options);
  Future<RegisterTeacherResponse> registerTeacher(RegisterTeacherOptions options);
  Future<UpdateTeacherResponse> updateTeacher(UpdateTeacherOptions options);
  Future<DeleteTeacherResponse> deleteTeacher(DeleteTeacherOptions options);

}
