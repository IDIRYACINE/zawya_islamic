import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/layout/state/events.dart';
import 'package:zawya_islamic/application/features/layout/state/state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.initial()) {
    on<LogoutEvent>(_handleLogout);
    on<SetupAppEvent>(_handleSetupApp);
    on<LoginUserEvent>(_handleLoginUser);
    on<NavigateIndexEvent>(_handleNavigateIndex);
  }


  FutureOr<void> _handleLogout(LogoutEvent event, Emitter<AppState> emit) {
    emit(state.copyWith( user: null));
  }

  FutureOr<void> _handleSetupApp(SetupAppEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(appsetupBuilder: event.appSetupOptions));
  }

  FutureOr<void> _handleLoginUser(LoginUserEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(user: event.user));
  }

  FutureOr<void> _handleNavigateIndex(NavigateIndexEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }
}
