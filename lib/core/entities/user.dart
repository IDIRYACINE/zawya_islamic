import 'package:zawya_islamic/core/entities/shared/value_objects.dart';

class AdminId {
  final int value;

  AdminId(this.value);
}

class Admin {
  final AdminId id;
  final Name name;

  Admin({required this.id, required this.name});
}

enum UserRoles {
  admin,
  teacher,
  student,
  anonymous,
}


  UserRoles parseUserRolefromString(String raw) {
    switch (raw) {
      case "admin":
        return UserRoles.admin;
      case "teacher":
        return UserRoles.teacher;
      case "student":
        return UserRoles.student;

      default:
        return UserRoles.anonymous;
    }
  }

class User {
  final UserId id;
  final Name name;
  final UserRoles role;

  User({required this.id, required this.name, required this.role});
}
