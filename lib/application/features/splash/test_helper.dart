import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/entities/export.dart';

Future<void> loadTestGroups(GroupsBloc bloc) async {
  final groups = [
    Group(id: GroupId("g1"), name: Name("g1")),
    Group(id: GroupId("g2"), name: Name("g2")),
    Group(id: GroupId("g3"), name: Name("g3"))
  ];

  final event = LoadGroupsEvent(groups: groups);
  bloc.add(event);
}

Future<void> loadTestStudent(StudentsBloc bloc) async {
  final students = [
    Student(
      id: StudentId("s1"),
      name: Name('s1'),
      birthDate: BirthDate(
        DateTime.now(),
      ),
    ),
    Student(
      id: StudentId("s2"),
      name: Name('s2'),
      birthDate: BirthDate(
        DateTime.now(),
      ),
    ),
    Student(
      id: StudentId("s2"),
      name: Name('s2'),
      birthDate: BirthDate(
        DateTime.now(),
      ),
    )
  ];

  final event = LoadStudentsEvent(students: students);

  bloc.add(event);
}
