import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/teacher.dart';

class TeachersState {
  TeachersState({required this.teachers ,});

  final List<Teacher> teachers ;

  factory TeachersState.initialState() {
    return TeachersState(teachers: []);
  }

  TeachersState copyWith({ List<Teacher>? teachers, School? school}) {
    return TeachersState(
      teachers: teachers ?? this.teachers,
    );
  }
}
