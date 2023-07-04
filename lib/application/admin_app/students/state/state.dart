import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/entities/export.dart';

class StudentsState {
  StudentsState({required this.students, required this.group});

  final List<Student> students;
  final Group group;

  factory StudentsState.initialState() {
    return StudentsState(
        students: [], group: Group(id: GroupId(""), name: Name("")));
  }

  StudentsState copyWith({
    List<Student>? students,
    Group? group,
  }) {
    return StudentsState(
      students: students ?? this.students,
      group: group ?? this.group,
    );
  }
}
