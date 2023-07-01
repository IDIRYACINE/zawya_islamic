import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';

class StudentsState {
  StudentsState({required this.students, required this.school});

  final List<Student> students;
  final School school;

  factory StudentsState.initialState() {
    return StudentsState(
        students: [], school: School(id: SchoolId(""), name: Name("")));
  }

  StudentsState copyWith({
    List<Student>? students,
    School? school,
  }) {
    return StudentsState(
      students: students ?? this.students,
      school: school ?? this.school,
    );
  }
}
