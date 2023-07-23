import 'package:habit_goal/src/models/auth_models.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthCheck extends AuthEvent {
  const AuthCheck();
}

class SetAuthState extends AuthEvent {
  final UserAuth? userAuth;
  final bool isAuth;
  final bool? isAnonymous;

  const SetAuthState({
    this.userAuth,
    required this.isAuth,
    this.isAnonymous = false,
  });
}
