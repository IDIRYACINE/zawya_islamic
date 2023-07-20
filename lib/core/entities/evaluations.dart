import 'quran.dart';
import 'student.dart';

class Evaluation {
  final Surat? surat;
  final Ayat? start, end;

  Evaluation({this.surat, this.start, this.end});
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
}
