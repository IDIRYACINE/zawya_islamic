import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/entities/export.dart';

class StudentsState {
  StudentsState(
      {required this.students, required this.presence, required this.group});

  final List<Student> students;
  final List<Student> presence;
  final Group group;

  factory StudentsState.initialState() {
    return StudentsState(
        presence: [],
        students: [],
        group: Group(id: GroupId(""), name: Name("")));
  }

  StudentsState copyWith({
    List<Student>? students,
    List<Student>? presence,
    Group? group,
  }) {
    return StudentsState(
      students: students ?? this.students,
      group: group ?? this.group,
      presence: presence ?? this.presence,
    );
  }


  List<Student> get absence => students.where((element) => !presence.contains(element)).toList();
}
