import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/params/params.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecase/login_user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;

  LoginBloc({required this.loginUser}) : super(LoginInitial());

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUserEvent) {
      yield LoginLoading();

      final result = await loginUser.call(
        User(
          email: event.email,
          password: event.password,
        ) as LoginParams,
      );

      yield* result.fold(
        (failure) async* {
          yield LoginError(message: _mapFailureToMessage(failure));
        },
        (user) async* {
          yield LoginSuccess(user: user);
        },
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Error';
    } else if (failure is ConnectionFailure) {
      return 'Connection Error';
    } else {
      return 'Unexpected Error';
    }
  }
}
