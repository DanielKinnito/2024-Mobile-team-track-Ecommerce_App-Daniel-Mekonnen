import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/params/params.dart';
import '../../domain/usecase/login_user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;
  final SharedPreferences sharedPreferences;

  LoginBloc({required this.loginUser, required this.sharedPreferences})
      : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      // Simulate a delay before emitting the loading state
      await Future.delayed(const Duration(seconds: 1));

      emit(LoginLoading());

      // Await the result of the loginUser use case
      final loginResult = await loginUser(
        LoginParams(
          email: event.email,
          password: event.password,
        ),
      );

      // Process the result of loginUser
      await loginResult.fold(
        (failure) async {
          // Emit failure state if login fails
          emit(LoginFailure(message: failure.message));
        },
        (token) async {
          // Store the access token in SharedPreferences
          await sharedPreferences.setString('access_token', token);

          // Emit success state if login succeeds
          emit(LoginSuccess(token: token));
        },
      );
    });
  }
}
