import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';

typedef LoadStudentsResponse = StudentServiceResponse<List<Student>>;
typedef LoadStudentResponse = StudentServiceResponse<Student>;
typedef RegisterStudentResponse = StudentServiceResponse<void>;
typedef UpdateStudentResponse = StudentServiceResponse<void>;
typedef DeleteStudentResponse = StudentServiceResponse<void>;
typedef SearchStudentResponse
    = StudentServiceResponse<List<StudentEvaluationAndPresence>>;

typedef GroupPresenceAndEvaluationResponse
    = StudentServiceResponse<List<StudentEvaluationAndPresence>>;

typedef SchoolPresenceAndEvaluationResponse
    = StudentServiceResponse<List<PresenseAndEvaluationHolder>>;

typedef MarkPresenceResponse = StudentServiceResponse<void>;
typedef MarkEvaluationResponse = StudentServiceResponse<void>;

class PresenseAndEvaluationHolder {
  final GroupId groupId;
  final List<Presence>? presences;
  final List<Evaluation>? evaluations;

  PresenseAndEvaluationHolder(
      {required this.groupId, this.presences, this.evaluations}) {
    assert(presences == null && evaluations == null,
        "Must load presences or evaluations or both");
  }
}

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

  LoadStudentsOptions({this.groupId, this.schoolId}) {
    assert(groupId != null || schoolId != null,
        "Must provide schoolId or groupId");
  }
}

class LoadStudentOptions extends StudentServiceOptions {
  final StudentId studentId;
  final GroupId groupId;

  LoadStudentOptions({required this.groupId, required this.studentId});
}

class RegisterStudentOptions extends StudentServiceOptions {
  final Student student;

  RegisterStudentOptions({
    required this.student,
  });
}

class UpdateStudentOptions extends StudentServiceOptions {
  final Student student;

  UpdateStudentOptions({required this.student});
}

class DeleteStudentOptions extends StudentServiceOptions {
  final StudentId studentId;
  final GroupId groupId;

  DeleteStudentOptions({required this.groupId, required this.studentId});
}

class LoadSchoolPresenceAndEvaluationOptions extends StudentServiceOptions {
  final List<String>? groupsIds;
  final SchoolId schoolId;

  LoadSchoolPresenceAndEvaluationOptions(
      {required this.schoolId, this.groupsIds});
}

class LoadGroupPresenceAndEvaluationOptions extends StudentServiceOptions {
  final GroupId groupId;
  final SchoolId? schoolId;

  LoadGroupPresenceAndEvaluationOptions({this.schoolId, required this.groupId});
}

class MarkPresenceOptions extends StudentServiceOptions {
  final StudentPresence? presence;
  final List<StudentPresence>? presences;
  final GroupId? groupId;
  final SessionId? sessionId;

  MarkPresenceOptions(
      {this.presence, this.presences, this.sessionId, this.groupId}) {
    assert(presence == null || presences == null,
        "Either presence or presences must be provided");
  }
}

class MarkEvaluationOptions extends StudentServiceOptions {
  final StudentEvaluation evaluation;
  final SchoolId? schoolId;
  final GroupId? groupId;

  MarkEvaluationOptions(
      {required this.evaluation, this.schoolId, this.groupId});
}

class SearchStudentOptions extends StudentServiceOptions {
  final String studentName;
  final SchoolId schoolId;

  SearchStudentOptions({required this.studentName, required this.schoolId});
}


abstract class StudentServicePort {
  Future<LoadStudentResponse> getStudent(LoadStudentOptions options);
  Future<LoadStudentsResponse> getStudents(LoadStudentsOptions options);
  Future<RegisterStudentResponse> registerStudent(
      RegisterStudentOptions options);
  Future<UpdateStudentResponse> updateStudent(UpdateStudentOptions options);
  Future<DeleteStudentResponse> deleteStudent(DeleteStudentOptions options);
  Future<GroupPresenceAndEvaluationResponse> loadGroupPresenceAndEvaluations(
      LoadGroupPresenceAndEvaluationOptions options);
  Future<MarkPresenceResponse> markPresenceOrAbsence(
      MarkPresenceOptions options);
  Future<MarkEvaluationResponse> markMonthlyEvaluation(
      MarkEvaluationOptions options);

  Future<SearchStudentResponse> searchStudent(SearchStudentOptions options);
}
