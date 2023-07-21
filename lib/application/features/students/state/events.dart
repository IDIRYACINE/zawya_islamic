import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/entities/export.dart';

abstract class StudentEvent {}

class CreateStudentEvent extends StudentEvent {
  final Student student;
  CreateStudentEvent({required this.student});
}


class UpdateStudentEvent extends StudentEvent{
  final Student student;
  UpdateStudentEvent({required this.student});
}

class DeleteStudentEvent extends StudentEvent{
  final Student student;

  DeleteStudentEvent({required this.student});
}

class LoadStudentsEvent extends StudentEvent{
  final List<Student> students;
  LoadStudentsEvent({required this.students});
}


class SetGroupEvent extends StudentEvent{
  final Group group;
  
  SetGroupEvent({required this.group});
}

class LoadPresencesAndEvaluations extends StudentEvent{
  final List<StudentEvaluationAndPresence> evaluations;

  LoadPresencesAndEvaluations({required this.evaluations});
}


class MarkStudentPresence extends StudentEvent{
  final StudentEvaluationAndPresence evaluation;

  MarkStudentPresence({required this.evaluation});
}

class MarkStudentAbsence extends StudentEvent{
  final StudentEvaluationAndPresence evaluation;

  MarkStudentAbsence({required this.evaluation});
}

class UnMarkStudentEvaluation extends StudentEvent{
  final StudentEvaluationAndPresence evaluation;

  UnMarkStudentEvaluation({required this.evaluation});
}

class MarkStudentEvaluation extends StudentEvent{
  final StudentEvaluationAndPresence evaluation;

  MarkStudentEvaluation({required this.evaluation});
}


class SetSession extends StudentEvent{
  final Session? session;

  SetSession({ this.session});
}