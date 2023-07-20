import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';

typedef LoadStudentsResponse = StudentServiceResponse<List<Student>>;
typedef LoadStudentResponse = StudentServiceResponse<Student>;
typedef RegisterStudentResponse = StudentServiceResponse<void>;
typedef UpdateStudentResponse = StudentServiceResponse<void>;
typedef DeleteStudentResponse = StudentServiceResponse<void>;

class StudentServiceResponse<T> {
  final String? message;
  final bool success;
  final T data;

  StudentServiceResponse(
      {this.message, this.success = true, required this.data});
}

abstract class StudentServiceOptions {}

class LoadStudentsOptions extends StudentServiceOptions {
  final GroupId? groupId;
  final SchoolId? schoolId;

  LoadStudentsOptions({ this.groupId, this.schoolId}){
    assert(groupId !=null || schoolId !=null ,"Must provide schoolId or groupId");
  }
}

class LoadStudentOptions extends StudentServiceOptions {
  final StudentId studentId;
  final GroupId groupId;

  LoadStudentOptions({required this.groupId, required this.studentId});
}

class RegisterStudentOptions extends StudentServiceOptions {
  final Student student;
  final GroupId groupId;

  RegisterStudentOptions({required this.student, required this.groupId});
}

class UpdateStudentOptions extends StudentServiceOptions {
  final Student student;
  final GroupId groupId;

  UpdateStudentOptions({required this.student, required this.groupId});
}

class DeleteStudentOptions extends StudentServiceOptions {
  final StudentId studentId;
  final GroupId groupId;

  DeleteStudentOptions({required this.groupId, required this.studentId});
}

abstract class StudentServicePort {
  Future<LoadStudentResponse> getStudent(LoadStudentOptions options);
  Future<LoadStudentsResponse> getStudents(LoadStudentsOptions options);
  Future<RegisterStudentResponse> registerStudent(
      RegisterStudentOptions options);
  Future<UpdateStudentResponse> updateStudent(UpdateStudentOptions options);
  Future<DeleteStudentResponse> deleteStudent(DeleteStudentOptions options);
}
