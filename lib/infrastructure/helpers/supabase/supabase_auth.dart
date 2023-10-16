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

  @override
  Future<void> sendPasswordReset({required String email}) async {
    _client.auth.resetPasswordForEmail(email);
  }

  @override
  Future<User?> setNewPassword(
      {required String otp,
      required String email,
      required String newPassword}) async {
    final auth = _client.auth;

    final res = await auth
        .verifyOTP(token: otp, type: supabase.OtpType.email, email: email)
        .onError((error, stackTrace) => supabase.AuthResponse());

    _updatePassowrd(newPassword, res);

    final user = res.user == null
        ? null
        : User(
            id: UserId(res.user!.id),
            name: Name(""),
            role: UserRoles.anonymous,
          );

    return user;
  }

  supabase.AuthResponse _updatePassowrd(
      String newPassword, supabase.AuthResponse response) {
    final auth = _client.auth;
    auth.updateUser(supabase.UserAttributes(password: newPassword));
    return response;
  }
}
