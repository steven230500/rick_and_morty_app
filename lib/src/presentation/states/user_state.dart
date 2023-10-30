import 'package:rick_and_morty_app/src/data/models/user.dart';

class UserState {
  final User? user;
  final bool isLoading;
  final bool loginSuccess;
  final String? loginError;

  UserState({
    required this.user,
    required this.isLoading,
    this.loginSuccess = false,
    this.loginError,
  });

  factory UserState.initial() {
    return UserState(user: null, isLoading: false);
  }

  factory UserState.loading() {
    return UserState(user: null, isLoading: true);
  }

  factory UserState.success(User user) {
    return UserState(user: user, isLoading: false, loginSuccess: true);
  }

  factory UserState.error(String errorMessage) {
    return UserState(user: null, isLoading: false, loginError: errorMessage);
  }

  UserState copyWith({
    User? user,
    bool? isLoading,
    bool? loginSuccess,
    String? loginError,
  }) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      loginSuccess: loginSuccess ?? this.loginSuccess,
      loginError: loginError ?? this.loginError,
    );
  }
}
