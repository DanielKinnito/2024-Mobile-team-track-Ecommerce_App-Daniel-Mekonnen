import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/params/params.dart';
import '../../domain/usecase/register_user.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUser registerUser;

  RegisterBloc({required this.registerUser}) : super(RegisterInitial()) {
    on<RegisterUserEvent>(_onRegisterUser);
  }

  void _onRegisterUser(
      RegisterUserEvent event, Emitter<RegisterState> emit) async {
    if (kDebugMode) {
      print('Handling RegisterUserEvent');
    }
    emit(RegisterLoading());
    final result = await registerUser(RegisterParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));
    emit(result.fold(
      (failure) => RegisterError(failure.message),
      (_) => RegisterSuccess(),
    ));
  }
}
