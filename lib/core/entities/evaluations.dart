import 'quran.dart';
import 'student.dart';

enum EvaluationType {
  ayat,
  thomon,
  quarter,
  half,
  hazeb,
}

extension EvaluationExtension on EvaluationType {
  String get arabic {
    switch (this) {
      case EvaluationType.ayat:
        return "اية";

      case EvaluationType.thomon:
        return "ثمن";

      case EvaluationType.quarter:
        return "ربع";

      case EvaluationType.half:
        return "نصف حزب";

      case EvaluationType.hazeb:
        return "حزب";
    }
  }
}


class Evaluation {
  final int modifier;
  final EvaluationType type;

  Evaluation({required this.modifier,required this.type});
  
}

class EvaluationByAyat{
  final Surat? surat;
  final Ayat? start,end;

  EvaluationByAyat({this.surat, this.start, this.end});
}

class StudentEvaluation {
  final Student student;
  final EvaluationByAyat evaluation;

  StudentEvaluation(this.student, this.evaluation);

  bool equals(StudentEvaluation studentEvaluation) {
    return student.equals(studentEvaluation.student);
  }

  static StudentEvaluation zeroEvaluation(Student student) {
    return StudentEvaluation(student, EvaluationByAyat());
  }
}
