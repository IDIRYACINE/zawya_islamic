import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/teacher.dart';

class TeachersState {
  TeachersState({required this.teachers ,required this.school});

  final List<Teacher> teachers ;
  final School school;

  factory TeachersState.initialState() {
    return TeachersState(teachers: [], school: School.empty());
  }

  TeachersState copyWith({ List<Teacher>? teachers, School? school}) {
    return TeachersState(
      teachers: teachers ?? this.teachers,
      school: school ?? this.school,
    );
  }
}
