import 'package:zawya_islamic/core/entities/export.dart';

class StudentsAggregate {
  final List<Student> _students;

  StudentsAggregate(this._students);

  List<Student> addStudent(Student student, [List<Student>? list]) {
    final List<Student> students = list ?? _students;

    students.add(student);

    return students;
  }

  List<Student> updateStudent(Student student) {
    final index = _students.indexWhere((element) => element.equals(student));
    if (index != -1) {
      _students[index] = student;
    }
    return _students;
  }

  List<Student> deleteStudent(Student student, [List<Student>? list]) {
    final List<Student> students = list ?? _students;

    students.removeWhere((element) => element.equals(student));

    return students;
  }

  List<Student> setStudents(List<Student> students) {
    _students.clear();
    _students.addAll(students);
    return _students;
  }

  List<Student> get students => _students;
}

class StudentEvaluationsAggregate {
  final List<StudentEvaluationAndPresence> _evaluations;

  StudentEvaluationsAggregate(this._evaluations);

  List<StudentEvaluationAndPresence> addStudentEvaluation(
      StudentEvaluationAndPresence studentEvaluation,
      [List<StudentEvaluationAndPresence>? list]) {
    final List<StudentEvaluationAndPresence> studentEvaluations =
        list ?? _evaluations;

    studentEvaluations.add(studentEvaluation);

    return studentEvaluations;
  }

  List<StudentEvaluationAndPresence> updateStudentEvaluation(
      StudentEvaluationAndPresence studentEvaluation) {
    final index = _evaluations.indexWhere(
        (element) => element.student.equals(studentEvaluation.student));
    if (index != -1) {
      _evaluations[index] = studentEvaluation;
    }
    return _evaluations;
  }

  List<StudentEvaluationAndPresence> deleteStudentEvaluation(
      StudentEvaluationAndPresence studentEvaluation,
      [List<StudentEvaluationAndPresence>? list]) {
    final List<StudentEvaluationAndPresence> studentEvaluations =
        list ?? _evaluations;

    studentEvaluations.removeWhere(
        (element) => element.student.equals(studentEvaluation.student));

    return studentEvaluations;
  }

  List<StudentEvaluationAndPresence> setStudentEvaluations(
      List<StudentEvaluationAndPresence> studentEvaluations) {
    _evaluations.clear();
    _evaluations.addAll(studentEvaluations);
    return _evaluations;
  }

  List<StudentEvaluationAndPresence> get studentEvaluations => _evaluations;

  List<StudentEvaluationAndPresence> updateAllByPresence() {
    final List<StudentEvaluationAndPresence> updated = [];

    for (StudentEvaluationAndPresence presence in studentEvaluations) {
      updated.add(presence.updatePresenceCount());
    }

    setStudentEvaluations(updated);

    return updated;
  }
}
