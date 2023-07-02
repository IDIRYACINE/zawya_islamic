import 'package:flutter/material.dart';

import '../logic/ports.dart';

class AppState {

  final bool isAuth;
  final String userId;
  final AppSetupOptions appsetupBuilder;
  final int selectedIndex ;

  AppState._( {required this.selectedIndex, required this.isAuth, required this.userId,required this.appsetupBuilder,});

  AppState copyWith({
    bool? isAuth,
    String? userId,
    AppSetupOptions? appsetupBuilder,
    int? selectedIndex,
  }) {
    return AppState._(
      selectedIndex: selectedIndex??this.selectedIndex,
      isAuth: isAuth ?? this.isAuth,
      userId: userId ?? this.userId,
      appsetupBuilder: appsetupBuilder??this.appsetupBuilder,
    );
  }

  factory AppState.initial() {
    return AppState._(
      selectedIndex: 0,
      isAuth: false,
      userId: '',
      appsetupBuilder: AppSetupOptions(
        bodyBuilder: (index) => Container(),
        bottomNavigationBarBuilder: (index) => Container(),
      ),
    );
  }
}
