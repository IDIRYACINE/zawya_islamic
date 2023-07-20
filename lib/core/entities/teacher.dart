import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/infrastructure/ports/database_tables_port.dart';

class TeacherId {
  final String value;

  TeacherId(this.value);

  bool equals(TeacherId id) {
    return value == id.value;
  }

  UserId toUserId() {
    return UserId(value);
  }
}

class Teacher {
  final TeacherId id;
  final Name name;
  final List<GroupId> groups;
  final SchoolId schoolId;

  Teacher(
      {required this.schoolId,
      required this.id,
      required this.name,
      required this.groups});

  factory Teacher.fromMap(Map<String, dynamic> json) {
    return Teacher(
      id: TeacherId(json[UserTable.userId.name]),
      name: Name(json[UserTable.userName.name]),
      groups: [],
      schoolId: SchoolId(json[UserTable.schoolId.name]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      UserTable.userId.name: id.value,
      UserTable.userName.name: name.value,
      UserTable.userRole.name: UserRoles.teacher.index,
      UserTable.schoolId.name : schoolId.value
    };
  }

  Teacher copyWith({Name? name, List<GroupId>? groups, SchoolId? schoolId}) {
    return Teacher(
        id: id,
        name: name ?? this.name,
        groups: groups ?? this.groups,
        schoolId: schoolId ?? this.schoolId);
  }

  bool equals(Teacher teacher) {
    return id.equals(teacher.id);
  }
}
