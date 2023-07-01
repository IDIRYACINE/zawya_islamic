

import 'package:zawya_islamic/core/entities/export.dart';

class StudentsAggregate{
  final List<Student> _students;

  StudentsAggregate(this._students);

  List<Student> addStudent(Student student) {
    _students.add(student);
    return _students;
  }

  List<Student> updateStudent(Student student) {
    final index = _students.indexWhere((element) => element.equals(student));
    if (index != -1) {
      _students[index] = student;
    }
    return _students;
  }

  List<Student> deleteStudent(Student student) {
    _students.removeWhere((element) => element.equals(student));

    return _students;
  }

  List<Student> setStudents(List<Student> students) {
    _students.clear();
    _students.setAll(0, students);
    return _students;
  }

  List<Student> get students => _students;
}