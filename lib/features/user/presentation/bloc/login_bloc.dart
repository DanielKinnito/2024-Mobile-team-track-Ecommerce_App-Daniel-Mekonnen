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

  LoginBloc({required this.loginUser, required this.sharedPreferences}) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      final loginResult = await loginUser(
        LoginParams(
          email: event.email,
          password: event.password,
        ),
      );

      loginResult.fold(
        (failure) {
          emit(LoginFailure(message: failure.message));
        },
        (token) async {
          // Store the access token in SharedPreferences
          await sharedPreferences.setString('access_token', token);
          
          emit(LoginSuccess(token: token));
        },
      );
    });
  }
}
