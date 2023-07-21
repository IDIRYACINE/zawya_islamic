import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';

typedef LoadStudentsResponse = StudentServiceResponse<List<Student>>;
typedef LoadStudentResponse = StudentServiceResponse<Student>;
typedef RegisterStudentResponse = StudentServiceResponse<void>;
typedef UpdateStudentResponse = StudentServiceResponse<void>;
typedef DeleteStudentResponse = StudentServiceResponse<void>;

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


class LoadSchoolPresenceAndEvaluationOptions
    extends StudentServiceOptions {
  final List<String>? groupsIds;
  final SchoolId schoolId;

  LoadSchoolPresenceAndEvaluationOptions(
      {required this.schoolId, this.groupsIds});
}

class LoadGroupPresenceAndEvaluationOptions
    extends StudentServiceOptions {
  final GroupId groupId;
  final SchoolId? schoolId;

  LoadGroupPresenceAndEvaluationOptions(
      { this.schoolId, required this.groupId});
}

class MarkPresenceOptions extends StudentServiceOptions {
  final Presence? presence;
  final List<Presence>? presences;
  final GroupId groupId;
  final SessionId sessionId;

  MarkPresenceOptions(
      {this.presence,
      this.presences,
      required this.sessionId,
      required this.groupId}) {
    assert(presence == null || presences == null,
        "Either presence or presences must be provided");
    assert((presences != null) && (presences?.isEmpty == true),
        "Presences is Empty");
  }
}

class MarkEvaluationOptions extends StudentServiceOptions {
  final Evaluation evaluation;
  final SchoolId schoolId;
  final GroupId groupId;

  MarkEvaluationOptions(
      {required this.evaluation,
      required this.schoolId,
      required this.groupId});
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
  
}
