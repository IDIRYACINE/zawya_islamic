import 'package:zawya_islamic/core/entities/export.dart';

import 'evaluations.dart';

enum PresenceType { present, absent }

class Presence {
  final PresenceType type;
  final int modifer;

  Presence({required this.type, required this.modifer});
}

class StudentPresence {
  final Presence presence;
  final Presence absence;
  final StudentId studentId;

  final PresenceType currentSessionPresence;

  StudentPresence({
    required this.studentId,
    required this.presence,
    required this.absence,
    this.currentSessionPresence = PresenceType.absent,
  });

  bool get isAbsent =>
      currentSessionPresence.index == PresenceType.absent.index;

  bool get isPresent =>
      currentSessionPresence.index == PresenceType.present.index;

  StudentPresence copyWith({PresenceType? currentSessionPresence}) {
    return StudentPresence(
      absence: absence,
      currentSessionPresence:
          currentSessionPresence ?? this.currentSessionPresence,
      presence: presence,
      studentId: studentId,
    );
  }
}

class StudentEvaluationAndPresence {
  final Student student;

  final StudentPresence presence;
  final StudentEvaluation evaluation;

  StudentEvaluationAndPresence(
      {required this.student,
      required this.presence,
      required this.evaluation});

  StudentEvaluationAndPresence copyWith(
      {StudentPresence? presence, StudentEvaluation? evaluation}) {
    return StudentEvaluationAndPresence(
        student: student,
        presence: presence ?? this.presence,
        evaluation: evaluation ?? this.evaluation);
  }
}
