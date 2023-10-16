import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/infrastructure/ports/database_tables_port.dart';

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

  int get totalPresenceCount => presence.modifer + absence.modifer;

  StudentPresence copyWith(
      {PresenceType? currentSessionPresence,
      Presence? presence,
      Presence? absence}) {
    return StudentPresence(
      absence: absence ?? this.absence,
      currentSessionPresence:
          currentSessionPresence ?? this.currentSessionPresence,
      presence: presence ?? this.presence,
      studentId: studentId,
    );
  }

  factory StudentPresence.fromMap(Map<String, dynamic> raw) {
    final absenceParsed = Presence(
        type: PresenceType.absent,
        modifer: raw[StudentEvaluationAndPresenceTable.absence.name]);
    final presenceParsed = Presence(
        type: PresenceType.present,
        modifer: raw[StudentEvaluationAndPresenceTable.presence.name]);
    final studentIdParsed =
        StudentId(raw[StudentEvaluationAndPresenceTable.userId.name]);

    return StudentPresence(
        absence: absenceParsed,
        presence: presenceParsed,
        studentId: studentIdParsed);
  }

  Map<String, dynamic> toMap({bool updated = false}) {
    return {
      StudentEvaluationAndPresenceTable.presence.name: presence.modifer,
      StudentEvaluationAndPresenceTable.absence.name: absence.modifer,
      "userId": studentId.value,
    };
  }
}

class StudentEvaluationAndPresence {
  final Student student;

  final StudentPresence presence;
  final StudentEvaluation evaluation;

  factory StudentEvaluationAndPresence.fromMap(Map<String, dynamic> raw) {
    return StudentEvaluationAndPresence(
      presence: StudentPresence.fromMap(raw),
      evaluation: StudentEvaluation.fromMap(raw),
      student: Student.fromMap(raw),
    );
  }

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

  StudentEvaluationAndPresence updatePresenceCount() {
    int presenceModifier = presence.presence.modifer;
    int absenceModifier = presence.absence.modifer;

   if(presence.isPresent){
      presenceModifier++;
   }

   if(presence.isAbsent){
    absenceModifier++;
   }

   final updatedPresence = presence.copyWith(
      presence: Presence(type: PresenceType.present, modifer: presenceModifier),
      absence: Presence(type: PresenceType.absent, modifer: absenceModifier),
    );


    return copyWith(
        presence: updatedPresence);
  }
}

class MonthlyPresenceStats {
  final int totalPresenceCount;
  final int totalAbsenceCount;
  final SchoolId schoolId;

  MonthlyPresenceStats({
    required this.schoolId,
    required this.totalPresenceCount,
    required this.totalAbsenceCount,
  });

  factory MonthlyPresenceStats.empty() {
    return MonthlyPresenceStats(
      schoolId: SchoolId(""),
      totalAbsenceCount: -1,
      totalPresenceCount: -1,
    );
  }

  factory MonthlyPresenceStats.fromMap(Map<String, dynamic> raw) {
    return MonthlyPresenceStats(
      schoolId: SchoolId(raw[SchoolTable.schoolId.name]),
      totalAbsenceCount: raw[StudentEvaluationAndPresenceTable.absence.name],
      totalPresenceCount: raw[StudentEvaluationAndPresenceTable.presence.name],
    );
  }
}
