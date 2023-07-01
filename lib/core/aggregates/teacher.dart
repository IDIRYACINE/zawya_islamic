
import 'package:zawya_islamic/core/entities/export.dart';

class TeachersAggregate{
  final List<Teacher> _teachers;

  TeachersAggregate(this._teachers);

  List<Teacher> addTeacher(Teacher teacher) {
    _teachers.add(teacher);
    return _teachers;
  }

  List<Teacher> updateTeacher(Teacher teacher) {
    final index = _teachers.indexWhere((element) => element.equals(teacher));
    if (index != -1) {
      _teachers[index] = teacher;
    }
    return _teachers;
  }

  List<Teacher> deleteTeacher(Teacher teacher) {
    _teachers.removeWhere((element) => element.equals(teacher));

    return _teachers;
  }

  List<Teacher> setTeachers(List<Teacher> Teachers) {
    _teachers.clear();
    _teachers.setAll(0, Teachers);
    return _teachers;
  }

  List<Teacher> get Teachers => _teachers;
}