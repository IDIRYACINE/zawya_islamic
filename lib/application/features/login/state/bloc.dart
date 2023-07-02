import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/login/state/events.dart';
import 'package:zawya_islamic/application/features/login/state/state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<LoginEvent>(_handleLogin);
    on<LogoutEvent>(_handleLogout);
  }

  FutureOr<void> _handleLogin(LoginEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(isAuth: true, userId: '123'));
  }

  FutureOr<void> _handleLogout(LogoutEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(isAuth: false, userId: ''));
  }
}
