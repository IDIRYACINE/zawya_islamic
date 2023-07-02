import 'package:zawya_islamic/core/entities/export.dart';

import '../logic/ports.dart';

abstract class AppEvent {}

class LoginEvent extends AppEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}


class LoginUserEvent extends AppEvent {
  final User user;

  LoginUserEvent({required this.user,});
}

class LogoutEvent extends AppEvent {
  LogoutEvent();
}

class SetupAppEvent extends AppEvent {
  final AppSetupOptions appSetupOptions;
  SetupAppEvent(this.appSetupOptions);
}

class NavigateIndexEvent extends AppEvent {
  final int index;
  NavigateIndexEvent(this.index);
}
