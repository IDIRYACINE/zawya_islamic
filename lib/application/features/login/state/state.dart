class AuthState {
  final bool isAuth;
  final String userId;

  AuthState._({required this.isAuth, required this.userId});

  AuthState copyWith({
    bool? isAuth,
    String? userId,
  }) {
    return AuthState._(
      isAuth: isAuth ?? this.isAuth,
      userId: userId ?? this.userId,
    );
  }

  factory AuthState.initial() {
    return AuthState._(
      isAuth: false,
      userId: '',
    );
  }
}
