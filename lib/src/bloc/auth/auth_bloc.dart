import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_goal/src/bloc/auth/auth_events.dart';
import 'package:habit_goal/src/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(super.initialState) {
    on<AuthCheck>((event, emit) {
      emit(AuthState.initial());
    });
    on<SetAuthState>((event, emit) {
      emit(AuthState(isAuth: event.isAuth, userAuth: event.userAuth));
    });
  }
}
