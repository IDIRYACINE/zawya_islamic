import 'package:zawya_islamic/core/entities/export.dart';

class AuthResponse {
  final String? message;
  final bool success;
  final UserId data;

  AuthResponse({this.message, this.success = true, required this.data});
}

abstract class AuthServicePort {
  Future<AuthResponse> login(
      {required String identifier, required String password});
}
