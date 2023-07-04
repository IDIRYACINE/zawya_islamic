import 'package:flutter/material.dart';
import 'package:zawya_islamic/core/entities/export.dart';

import '../logic/ports.dart';

class AppState {
  final User? user;
  final AppSetupOptions appsetupBuilder;
  final int selectedIndex;

  AppState._({
    required this.selectedIndex,
    this.user,
    required this.appsetupBuilder,
  });

  AppState copyWith({
    User? user,
    AppSetupOptions? appsetupBuilder,
    int? selectedIndex,
  }) {
    return AppState._(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      user: user ?? this.user,
      appsetupBuilder: appsetupBuilder ?? this.appsetupBuilder,
    );
  }

  factory AppState.initial() {
    return AppState._(
      selectedIndex: 0,
      appsetupBuilder: AppSetupOptions(
        bodyBuilder: (index) => Container(),
        bottomNavigationBarBuilder: (index) => Container(),
      ),
    );
  }

  bool get isAuth => user != null;
}
