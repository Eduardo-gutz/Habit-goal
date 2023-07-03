import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_goal/src/bloc/auth/auth_bloc.dart';
import 'package:habit_goal/src/bloc/auth/auth_state.dart';

class AuthGuard extends StatefulWidget {
  final Widget child;

  const AuthGuard({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthBloc, AuthState, bool>(
      selector: (state) => state.isAuth,
      builder: (context, isAuth) {
        if (!isAuth) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return widget.child;
      },
    );
  }
}
