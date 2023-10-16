import 'package:zawya_islamic/core/entities/export.dart';

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

    UserRoles parseUserRolefromNumbers(int raw) {
    switch (raw) {
      case 0:
        return UserRoles.admin;
      case 1:
        return UserRoles.teacher;
      case 2:
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

  TeacherId toTeacherId() {
    return TeacherId(id.value);
  }

  User copyWith({ UserRoles? role}) {
    return User(id: id, name: name, role: role??this.role);
  }
}
