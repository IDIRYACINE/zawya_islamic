

import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';

class StudentService implements StudentServicePort{
    final DatabasePort _databaseService;

  StudentService(this._databaseService);

  @override
  Future<DeleteStudentResponse> deleteStudent(DeleteStudentOptions options) {
    // TODO: implement deleteStudent
    throw UnimplementedError();
  }

  @override
  Future<LoadStudentResponse> getStudent(LoadStudentOptions options) {
    // TODO: implement getStudent
    throw UnimplementedError();
  }

  @override
  Future<LoadStudentsResponse> getStudents(LoadStudentsOptions options) {
    // TODO: implement getStudents
    throw UnimplementedError();
  }

  @override
  Future<RegisterStudentResponse> registerStudent(RegisterStudentOptions options) {
    // TODO: implement registerStudent
    throw UnimplementedError();
  }

  @override
  Future<UpdateStudentResponse> updateStudent(UpdateStudentOptions options) {
    // TODO: implement updateStudent
    throw UnimplementedError();
  }
}