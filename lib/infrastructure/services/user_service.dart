import 'package:firebase_auth/firebase_auth.dart';
import 'package:zawya_islamic/core/entities/export.dart' as app;
import 'package:zawya_islamic/core/ports/auth_service_port.dart';

class UserService implements AuthServicePort {
  final FirebaseAuth _auth;

  UserService(this._auth);

  @override
  Future<AuthResponse> login(
      {required String identifier, required String password}) async {

    app.User? user = await _auth
        .signInWithEmailAndPassword(email: identifier, password: password)
        .then((credentials) => _handleCredentials(credentials))
        .onError((error, stackTrace) => null);

    return AuthResponse(data: user);
    

    
  }

  app.User? _handleCredentials(UserCredential credentials) {
    final user = credentials.user;

    if (user == null) {
      return null;
    }

    return app.User(
      id: app.UserId(user.uid),
      name: app.Name(user.displayName ?? ""),
      role: app.UserRoles.admin,
    );
  }
}
