import 'package:zawya_islamic/core/entities/export.dart' as app;
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/auth_service_port.dart';
import 'package:zawya_islamic/core/ports/teacher_service_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_tables_port.dart';

class UserService implements AuthServicePort {
  final AuthPort _auth;
  final DatabasePort _database;
  final TeacherServicePort _teacherService;

  UserService(this._auth, this._database, this._teacherService);

  @override
  Future<AuthResponse> login(
      {required String identifier, required String password}) async {
    app.User? user = await _auth
        .signInWithEmailAndPassword(email: identifier, password: password)
        .then((res) async => await _handleCredentials(res.user))
        .onError((error, stackTrace) {
      return null;
    });

    return AuthResponse(user: user);
  }

  Future<app.User?> _handleCredentials(app.User? user) async {
    if (user == null) {
      return null;
    }

    final readOptions = ReadEntityOptions(
        metadata: {
          OptionsMetadata.rootCollection: DatabaseCollection.users.name,
          OptionsMetadata.lastId: user.id,
          OptionsMetadata.hasMany: false,
        },
        mapper: (data) => data["userRole"],
        filters: {UserTable.userId.name: user.id.value});

    final role = await _database.read<int>(readOptions);

    return user.copyWith(
      role: app.parseUserRolefromNumbers(role.data.first),
    );
  }

  @override
  Future<AuthResponse> registerUser(
      {required RegisterUserOptions options}) async {
    final authUser = await _auth.createUserWithEmailAndPassword(
        email: options.email, password: options.password);

    final id = authUser.user!.id.value;

    if (options.role == UserRoles.teacher) {
      final registerOptions = RegisterTeacherOptions(
          teacher: Teacher(
              id: TeacherId(id),
              name: Name(options.name),
              groups: [],
              schoolId: options.schoolId),
          schoolId: options.schoolId);
      _teacherService.registerTeacher(registerOptions);
    }

    final user =
        app.User(id: authUser.user!.id, name: app.Name(""), role: options.role);

    return AuthResponse(user: user);
  }
  
  @override
  Future<void> sendPasswordReset({required String email}) async {
    _auth.sendPasswordReset(email:email);
  }
  
  @override
  Future<app.User?> setNewPassword({required String otp,required String email,  required String newPassword}) {
    return _auth.setNewPassword(otp: otp, newPassword: newPassword,email:email);
  }
}
