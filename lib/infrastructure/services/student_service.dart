import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';

class StudentService implements StudentServicePort {
  final DatabasePort _databaseService;

  StudentService(this._databaseService);

  @override
  Future<DeleteStudentResponse> deleteStudent(
      DeleteStudentOptions options) async {
    final dbOptions = DeleteEntityOptions({
      OptionsMetadata.rootCollection:
          _generateStudentGroupCode(options.groupId.value),
      OptionsMetadata.lastId: options.studentId.value,
    });

    _databaseService.delete(dbOptions);

    return DeleteStudentResponse(data: null);
  }

  @override
  Future<LoadStudentResponse> getStudent(LoadStudentOptions options) async {
    final dbOptions = ReadEntityOptions({
      OptionsMetadata.rootCollection:
          _generateStudentGroupCode(options.groupId.value),
      OptionsMetadata.lastId: options.studentId.value,
      OptionsMetadata.hasMany: false,
    }, Student.fromMap);

    final response = await _databaseService.read<Student>(dbOptions);

    return LoadStudentResponse(data: response.data.first);
  }

  @override
  Future<LoadStudentsResponse> getStudents(LoadStudentsOptions options) async {
    final dbOptions = ReadEntityOptions({
      OptionsMetadata.rootCollection:
          _generateStudentGroupCode(options.groupId.value),
      OptionsMetadata.hasMany: true,
    }, Student.fromMap);

    final response = await _databaseService.read<Student>(dbOptions);

    return LoadStudentsResponse(data: response.data);
  }

  @override
  Future<RegisterStudentResponse> registerStudent(
      RegisterStudentOptions options) async {
    final dbOptions = CreateEntityOptions(options.student.toMap(), {
      OptionsMetadata.rootCollection:
          _generateStudentGroupCode(options.groupId.value),
      OptionsMetadata.lastId: options.student.id.value,
    });

    _databaseService.create(dbOptions);

    return RegisterStudentResponse(data: null);
  }

  @override
  Future<UpdateStudentResponse> updateStudent(
      UpdateStudentOptions options) async {
    final dbOptions = UpdateEntityOptions(options.student.toMap(), {
      OptionsMetadata.rootCollection:
          _generateStudentGroupCode(options.groupId.value),
      OptionsMetadata.lastId: options.student.id.value,
    });

    _databaseService.update(dbOptions);

    return UpdateStudentResponse(data: null);
  }

  String _generateStudentGroupCode(String groupId) {
    return "${DatabaseCollection.groupStudents.code}-$groupId";
  }
}
