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
