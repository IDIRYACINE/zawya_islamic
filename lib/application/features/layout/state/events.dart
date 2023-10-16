import 'package:zawya_islamic/core/entities/export.dart';

import '../logic/ports.dart';

abstract class AppEvent {}

class DataLoadedEvent extends AppEvent {
  final bool loaded;
  DataLoadedEvent([this.loaded = true]);
}

class LoginUserEvent extends AppEvent {
  final User user;

  LoginUserEvent({
    required this.user,
  });
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
