import 'package:habit_goal/src/models/auth_models.dart';

class AuthState {
  UserAuth? userAuth;
  final bool isAuth;
  final bool? isAnonymous;

  AuthState({
    required this.userAuth,
    required this.isAuth,
    this.isAnonymous = false,
  });

  factory AuthState.initial() {
    return AuthState(
      isAuth: false,
      userAuth: null,
      isAnonymous: false,
    );
  }
}
