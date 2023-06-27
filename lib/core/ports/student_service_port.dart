

import 'package:zawya_islamic/core/entities/export.dart';

typedef LoadStudentsResponse = StudentServiceResponse<List<Student>>;
typedef LoadStudentResponse = StudentServiceResponse<Student>;
typedef RegisterStudentResponse = StudentServiceResponse<void>;
typedef UpdateStudentResponse = StudentServiceResponse<void>;
typedef DeleteStudentResponse = StudentServiceResponse<void>;

abstract class StudentServiceResponse<T>{
  final String? message;
  final bool success;
  final T data;

  StudentServiceResponse({this.message, this.success = true, required this.data});
}


abstract class StudentServiceOptions{}

class LoadStudentsOptions extends StudentServiceOptions{
  final List<String> studentIds;

  LoadStudentsOptions({ this.studentIds = const []});
}

class LoadStudentOptions extends StudentServiceOptions{
  final StudentId studentId;

  LoadStudentOptions({required this.studentId});
}

class RegisterStudentOptions extends StudentServiceOptions{
  final Student student;

  RegisterStudentOptions({required this.student});
}

class UpdateStudentOptions extends StudentServiceOptions{
  final Student student;

  UpdateStudentOptions({required this.student});
}

class DeleteStudentOptions extends StudentServiceOptions{
  final StudentId studentId;

  DeleteStudentOptions({required this.studentId});
}

abstract class StudentServicePort{
  Future<LoadStudentResponse> getStudent(LoadStudentOptions options);
  Future<LoadStudentsResponse> getStudents(LoadStudentsOptions options);
  Future<RegisterStudentResponse> registerStudent(RegisterStudentOptions options);
  Future<UpdateStudentResponse> updateStudent(UpdateStudentOptions options);
  Future<DeleteStudentResponse> deleteStudent(DeleteStudentOptions options);
}