import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_goal/src/bloc/auth/auth_bloc.dart';
import 'package:habit_goal/src/bloc/auth/auth_state.dart';

class HGBlocsProvider extends StatelessWidget {
  final Widget child;
  const HGBlocsProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            AuthState.initial(),
          ),
        ),
      ],
      child: child,
    );
  }
}
