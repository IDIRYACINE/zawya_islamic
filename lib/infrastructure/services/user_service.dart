import 'package:firebase_auth/firebase_auth.dart';
import 'package:zawya_islamic/core/entities/export.dart' as app;
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/auth_service_port.dart';
import 'package:zawya_islamic/core/ports/teacher_service_port.dart';
import 'package:zawya_islamic/infrastructure/helpers/firebase/firestore_service.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';

class UserService implements AuthServicePort {
  final FirebaseAuth _auth;
  final FirestoreService _firestore;
  final TeacherServicePort _teacherService;

  UserService(this._auth, this._firestore, this._teacherService);

  @override
  Future<AuthResponse> login(
      {required String identifier, required String password}) async {
    app.User? user = await _auth
        .signInWithEmailAndPassword(email: identifier, password: password)
        .then((credentials) async => await _handleCredentials(credentials))
        .onError((error, stackTrace) => null);

    return AuthResponse(data: user);
  }

  Future<app.User?> _handleCredentials(UserCredential credentials) async {
    final user = credentials.user;

    if (user == null) {
      return null;
    }

    final readOptions = ReadEntityOptions({
      OptionsMetadata.rootCollection: DatabaseCollection.users.name,
      OptionsMetadata.lastId: user.uid,
      OptionsMetadata.hasMany: false,
    }, (data) => data["role"]);

    final role = await _firestore.read<String>(readOptions);

    return app.User(
      id: app.UserId(user.uid),
      name: app.Name(user.displayName ?? ""),
      role: app.parseUserRolefromString(role.data.first),
    );
  }

  @override
  Future<AuthResponse> registerUser(
      {required RegisterUserOptions options}) async {
    final authUser = await _auth.createUserWithEmailAndPassword(
        email: options.email, password: options.password);

    final id = authUser.user!.uid;

    CreateEntityOptions createOptions = CreateEntityOptions({
      "role": options.role.name,
      "name": options.name
    }, {
      OptionsMetadata.rootCollection: DatabaseCollection.users.name,
      OptionsMetadata.lastId: id,
      OptionsMetadata.hasMany: false,
    });

    _firestore.create(createOptions).then((value) {
      if (options.role == UserRoles.teacher) {
        final registerOptions = RegisterTeacherOptions(teacher:
         Teacher(id: TeacherId(id), name: Name(options.name), groups: []), 
         schoolId: options.schoolId);
        _teacherService.registerTeacher(registerOptions);
       
      }
    });

    final user = app.User(
        id: app.UserId(authUser.user!.uid),
        name: app.Name(""),
        role: options.role);

    return AuthResponse(data: user);
  }
}
