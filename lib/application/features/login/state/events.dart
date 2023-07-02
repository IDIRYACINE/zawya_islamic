import 'package:zawya_islamic/core/entities/export.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}


class LoginUserEvent extends AuthEvent {
  final User user;

  LoginUserEvent({required this.user,});
}

class LogoutEvent extends AuthEvent {
  LogoutEvent();
}