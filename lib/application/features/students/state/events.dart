import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/entities/evaluations.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/entities/session.dart';

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


class MarkStudentPresence extends StudentEvent{
  final Student student;

  MarkStudentPresence({required this.student});
}

class MarkStudentAbsence extends StudentEvent{
  final Student student;

  MarkStudentAbsence({required this.student});
}

class UnMarkStudentEvaluation extends StudentEvent{
  final StudentEvaluation evaluation;

  UnMarkStudentEvaluation({required this.evaluation});
}

class MarkStudentEvaluation extends StudentEvent{
  final StudentEvaluation evaluation;

  MarkStudentEvaluation({required this.evaluation});
}


class SetSession extends StudentEvent{
  final Session? session;

  SetSession({ this.session});
}