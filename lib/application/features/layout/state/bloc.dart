import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/layout/state/events.dart';
import 'package:zawya_islamic/application/features/layout/state/state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.initial()) {
    on<LoginEvent>(_handleLogin);
    on<LogoutEvent>(_handleLogout);
    on<SetupAppEvent>(_handleSetupApp);
  }

  FutureOr<void> _handleLogin(LoginEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(isAuth: true, userId: '123'));
  }

  FutureOr<void> _handleLogout(LogoutEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(isAuth: false, userId: ''));
  }

  FutureOr<void> _handleSetupApp(SetupAppEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(appsetupBuilder: event.appSetupOptions));
  }
}
