import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/infrastructure/ports/database_tables_port.dart';

class StudentId {
  final String value;

  StudentId(this.value);

  bool equals(StudentId id) {
    return value == id.value;
  }

  UserId toUserId() {
    return UserId(value);
  }
}

class Student {
  final StudentId id;
  final Name name;
  final BirthDate birthDate;
  final SchoolId schoolId;
  final GroupId groupId;

  Student(
      {required this.schoolId,
      required this.id,
      required this.groupId, 
      required this.name,
      required this.birthDate});
  factory Student.fromMap(Map<String, dynamic> json) {
    return Student(
      schoolId: SchoolId(json[UserTable.schoolId.name]),
      id: StudentId(json[UserTable.userId.name]),
      name: Name(json[UserTable.userName.name]),
      birthDate: BirthDate.fromString(json[UserTable.birthDate.name]), 
      groupId: GroupId(json[UserGroupsTable.groupId.name]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      UserTable.userId.name: id.value,
      UserTable.userName.name: name.value,
      UserTable.birthDate.name: birthDate.toPostgressDate(),
      UserTable.userRole.name: UserRoles.student.index,
      UserTable.schoolId.name: schoolId.value
    };
  }

  Student copyWith({
    StudentId? id,
    Name? name,
    BirthDate? birthDate,
    SchoolId? schoolId,
    GroupId? groupId,
  }) {
    return Student(
      schoolId: schoolId ?? this.schoolId,
      id: id ?? this.id,
      groupId: groupId?? this.groupId,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  bool equals(Student student) {
    return id.equals(student.id);
  }
}
