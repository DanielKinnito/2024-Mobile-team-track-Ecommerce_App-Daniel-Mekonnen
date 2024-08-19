import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/params/params.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecase/register_user.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUser registerUser;

  RegisterBloc({required this.registerUser}) : super(RegisterInitial());

  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterUserEvent) {
      yield RegisterLoading();
      final result = await registerUser.call(
        User(
          id: '', // Provide appropriate user ID or handle if needed
          name: event.name,
          email: event.email,
          password: event.password,
        ) as RegisterParams,
      );
      yield result.fold(
        (failure) => RegisterError(failure.message),
        (_) => RegisterSuccess(),
      );
    }
  }
}
