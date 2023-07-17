import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';

class AuthResponse {
  final String? message;
  final bool success;
  final User? user;

  AuthResponse({this.message, this.success = true, this.user});
}

class UpdateUserOptions{
  final String email;
  final String password;

  UpdateUserOptions({required this.email,required  this.password});
}

class DeleteUserOptions{
  final String id;

  DeleteUserOptions({required this.id});
}

class RegisterUserOptions {
  final String email;
  final String password;
  final UserRoles role;
  final String name;

  final SchoolId schoolId;

  RegisterUserOptions( 
      {required this.schoolId, required this.email,required this.name, required this.password, required this.role});
}

abstract class AuthServicePort {
  Future<AuthResponse> login(
      {required String identifier, required String password});

  Future<AuthResponse> registerUser({required RegisterUserOptions options});



}


abstract class AuthPort{
  Future<AuthResponse> signInWithEmailAndPassword({required String email, required String password});
  Future<AuthResponse> createUserWithEmailAndPassword({required String email, required String password});
}

class AuthCredentials {
  final dynamic credentials;

  AuthCredentials(this.credentials);
}
