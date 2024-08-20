import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/params/params.dart';
import '../usecase/auth_facade.dart';
import '../usecase/login_user.dart';
import '../usecase/register_user.dart';

class AuthFacadeImpl implements AuthFacade {
  final LoginUser loginUseCase;
  final RegisterUser registerUseCase;

  AuthFacadeImpl({
    required this.loginUseCase,
    required this.registerUseCase,
  });

  @override
  Future<Either<Failure, String>> loginUser(
      String email, String password) async {
    return await loginUseCase(LoginParams(email: email, password: password));
  }

  @override
  Future<Either<Failure, String>> registerUser(
      String email, String password, String name) async {
    return await registerUseCase(
        RegisterParams(email: email, name: name, password: password));
  }
}
