import 'package:firebase_auth/firebase_auth.dart';
import 'package:zawya_islamic/core/entities/shared/value_objects.dart';
import 'package:zawya_islamic/core/entities/user.dart';
import 'package:zawya_islamic/core/ports/auth_service_port.dart';
import 'package:zawya_islamic/core/entities/export.dart' as app;

class FirebaseAuthHelper implements AuthPort {
  final FirebaseAuth _auth;

  FirebaseAuthHelper(this._auth);

  @override
  Future<AuthResponse> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    final authUser = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    final user = app.User(
        id: app.UserId(authUser.user!.uid),
        name: app.Name(""),
        role: UserRoles.teacher);

    return AuthResponse(user: user);
  }

  @override
  Future<AuthResponse> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    final credentials = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    final id = credentials.user?.uid;

    if (id == null) {
      return AuthResponse();
    }

    return AuthResponse(
        user: app.User(
            id: UserId(id), name: app.Name(""), role: UserRoles.teacher));
  }
  
  @override
  Future<void> sendPasswordReset({required String email}) {
    throw UnimplementedError();
  }
  
  @override
  Future<app.User?> setNewPassword({required String otp, required String newPassword,required String email, }) {
    throw UnimplementedError();
  }
}
