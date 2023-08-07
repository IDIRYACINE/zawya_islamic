import 'package:flutter/material.dart';
import 'package:zawya_islamic/core/entities/export.dart';

import '../logic/ports.dart';

class AppState {
  final User? user;
  final AppSetupOptions appsetupBuilder;
  final int selectedIndex;
  final bool loaded;

  AppState._({
    required this.selectedIndex,
    this.user,
    required this.loaded,
    required this.appsetupBuilder,
  });

  AppState copyWith({
    User? user,
    AppSetupOptions? appsetupBuilder,
    bool? loaded,
    int? selectedIndex,
  }) {
    return AppState._(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      user: user ?? this.user,
      loaded: loaded ?? this.loaded,
      appsetupBuilder: appsetupBuilder ?? this.appsetupBuilder,
    );
  }

  factory AppState.initial() {
    return AppState._(
      selectedIndex: 0,
      loaded: false,
      appsetupBuilder: AppSetupOptions(
        bodyBuilder: (index) => Container(),
        bottomNavigationBarBuilder: (index) => Container(),
      ),
    );
  }

  bool get isAuth => user != null;
}
