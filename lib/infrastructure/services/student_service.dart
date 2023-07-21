import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_tables_port.dart';

class StudentService implements StudentServicePort {
  final DatabasePort _databaseService;

  StudentService(this._databaseService);

  @override
  Future<DeleteStudentResponse> deleteStudent(
      DeleteStudentOptions options) async {
    final dbOptions = DeleteEntityOptions(metadata: {
      OptionsMetadata.rootCollection: DatabaseCollection.users
    }, entries: {
      UserGroupsTable.groupId.name: options.groupId.value,
    });

    _databaseService.delete(dbOptions);

    return DeleteStudentResponse(data: null);
  }

  @override
  Future<LoadStudentResponse> getStudent(LoadStudentOptions options) async {
    final dbOptions = ReadEntityOptions(metadata: {
      OptionsMetadata.rootCollection:
          _generateStudentGroupCode(options.groupId.value),
      OptionsMetadata.lastId: options.studentId.value,
      OptionsMetadata.hasMany: false,
    }, filters: {
      UserTable.userRole.name: UserRoles.student.index
    }, mapper: Student.fromMap);

    final response = await _databaseService.read<Student>(dbOptions);

    return LoadStudentResponse(data: response.data.first);
  }

  @override
  Future<LoadStudentsResponse> getStudents(LoadStudentsOptions options) async {

    final targetSchoolOrGroup = options.schoolId !=null ;

    final metadata = {
      OptionsMetadata.rootCollection:
          targetSchoolOrGroup ? DatabaseViews.schoolStudents.name:DatabaseViews.groupStudents.name ,
      OptionsMetadata.hasMany: true,
    };

    final filterBySchoolOrGroupKey = targetSchoolOrGroup? GroupsTable.schoolId.name : GroupsTable.groupId.name;
    final filterBySchoolOrGroupValue = targetSchoolOrGroup? options.schoolId!.value : options.groupId!.value;

    final filters = {
      UserTable.userRole.name: UserRoles.student.index,
      filterBySchoolOrGroupKey : filterBySchoolOrGroupValue
    };

    final dbOptions = ReadEntityOptions(
        metadata: metadata, filters: filters, mapper: Student.fromMap);
    if (options.schoolId != null) {
    } else {}
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
    final dbOptions =
        UpdateEntityOptions(entity: options.student.toMap(), metadata: {
      OptionsMetadata.rootCollection:
          _generateStudentGroupCode(options.groupId.value),
      OptionsMetadata.lastId: options.student.id.value,
    }, filters: {
      UserTable.userId.name: options.student.id.value
    });

    _databaseService.update(dbOptions);

    return UpdateStudentResponse(data: null);
  }



  @override
  Future<GroupPresenceAndEvaluationResponse> loadGroupPresenceAndEvaluations(
      LoadGroupPresenceAndEvaluationOptions options) async {

    final dbOptions = ReadEntityOptions(
        metadata: {
          OptionsMetadata.rootCollection: DatabaseViews.groupStudentEvaluations.name,
          OptionsMetadata.hasMany: true,
        },
        mapper: StudentEvaluationAndPresence.fromMap,
        filters: {UserGroupsTable.groupId.name: options.groupId.value});

    final response = await _databaseService.read<StudentEvaluationAndPresence>(dbOptions);
    
    return GroupPresenceAndEvaluationResponse(data: response.data);
  }
  @override
  Future<MarkEvaluationResponse> markMonthlyEvaluation(
      MarkEvaluationOptions options) {
    throw UnimplementedError();
  }

  @override
  Future<MarkPresenceResponse> markPresenceOrAbsence(
      MarkPresenceOptions options) {
    throw UnimplementedError();
  }

  String _generateStudentGroupCode(String groupId) {
    // return "${DatabaseCollection.groupStudents.code}-$groupId";
    return DatabaseCollection.users.name;
  }
}
