import 'package:habit_goal/src/models/auth_models.dart';

class AuthState {
  UserAuth? userAuth;
  final bool isAuth;

  AuthState({
    required this.userAuth,
    required this.isAuth,
  });

  factory AuthState.initial() {
    return AuthState(
      isAuth: false,
      userAuth: null,
    );
  }
}
