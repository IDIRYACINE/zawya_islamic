import 'package:zawya_islamic/infrastructure/ports/database_tables_port.dart';

import 'quran.dart';
import 'student.dart';

class Evaluation {
  final Surat? surat;
  final Ayat? start, end;

  Evaluation({this.surat, this.start, this.end});

  factory Evaluation.fromMap(Map<String, dynamic> raw) {
    final surat = raw[StudentEvaluationAndPresenceTable.evaluationSurat] != null
        ? Surat(
            suratNumber: 1,
            name: raw[StudentEvaluationAndPresenceTable.evaluationSurat],
            ayatCount: 285)
        : null;

    final ayat = raw[StudentEvaluationAndPresenceTable.evaluationAyat] != null
        ? Ayat.fromNumber(
            raw[StudentEvaluationAndPresenceTable.evaluationAyat], 285)
        : null;

    return Evaluation(
      surat: surat,
      start: ayat,
      end: ayat,
    );
  }

  String get suratName =>  surat?.name ??  '?' ;
  int get ayatNumber => end?.number ??  -1 ;
}

class StudentEvaluation {
  final StudentId studentId;
  final Evaluation evaluation;

  StudentEvaluation({required this.studentId, required this.evaluation});

  bool equals(StudentEvaluation studentEvaluation) {
    return studentId.equals(studentEvaluation.studentId);
  }

  static StudentEvaluation zeroEvaluation(Student student) {
    return StudentEvaluation(studentId: student.id, evaluation: Evaluation());
  }

  StudentEvaluation copyWith({Evaluation? evaluation}) {
    return StudentEvaluation(
        evaluation: evaluation ?? this.evaluation, studentId: studentId);
  }

  factory StudentEvaluation.fromMap(Map<String, dynamic> raw) {
    return StudentEvaluation(
      evaluation: Evaluation.fromMap(raw),
      studentId: StudentId(raw[UserTable.userId.name]),
    );
  }
}
