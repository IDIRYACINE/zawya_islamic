import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/entities/export.dart';

abstract class StudentEvent {}

class CreateStudentEvent extends StudentEvent {
  final Student student;
  CreateStudentEvent({required this.student});
}

class UpdateStudentEvent extends StudentEvent {
  final Student student;
  UpdateStudentEvent({required this.student});
}

class DeleteStudentEvent extends StudentEvent {
  final Student student;

  DeleteStudentEvent({required this.student});
}

class LoadStudentsEvent extends StudentEvent {
  final List<Student> students;
  LoadStudentsEvent({required this.students});
}

class SetGroupEvent extends StudentEvent {
  final Group group;

  SetGroupEvent({required this.group});
}

class LoadPresencesAndEvaluationsEvent extends StudentEvent {
  final List<StudentEvaluationAndPresence> evaluations;

  LoadPresencesAndEvaluationsEvent({required this.evaluations});
}

class MarkStudentPresenceEvent extends StudentEvent {
  final StudentEvaluationAndPresence evaluation;

  MarkStudentPresenceEvent({required this.evaluation});
}

class MarkStudentAbsenceEvent extends StudentEvent {
  final StudentEvaluationAndPresence evaluation;

  MarkStudentAbsenceEvent({required this.evaluation});
}

class UnMarkStudentEvaluationEvent extends StudentEvent {
  final StudentEvaluationAndPresence evaluation;

  UnMarkStudentEvaluationEvent({required this.evaluation});
}

class MarkStudentEvaluationEvent extends StudentEvent {
  final StudentEvaluationAndPresence evaluation;

  MarkStudentEvaluationEvent({required this.evaluation});
}

class SetSessionEvent extends StudentEvent {
  final Session? session;
  final bool nullify;

  SetSessionEvent({this.session, this.nullify = false});
}
