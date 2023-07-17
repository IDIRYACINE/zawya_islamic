import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/auth_service_port.dart';

class SupabaseAuthHelper implements AuthPort {
  final supabase.SupabaseClient _client;

  SupabaseAuthHelper(this._client);

  @override
  Future<AuthResponse> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    final res = await _client.auth.signUp(email: email, password: password);

    final user =
        User(id: UserId(res.user!.id), name: Name(""), role: UserRoles.teacher);

    return AuthResponse(user: user);
  }

  @override
  Future<AuthResponse> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    final authUser =
        await _client.auth.signInWithPassword(email: email, password: password);

    if (authUser.user == null) {
      return AuthResponse();
    }

    return AuthResponse(
        user: User(
            id: UserId(authUser.user!.id),
            name: Name(""),
            role: UserRoles.admin));
  }
}
