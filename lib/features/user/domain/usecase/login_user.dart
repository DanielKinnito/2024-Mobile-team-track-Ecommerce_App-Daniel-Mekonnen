import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/params/params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class LoginUser extends Usecase<Future<Either<Failure, User>>, LoginParams> {
  final UserRepository userRepository;

  LoginUser(this.userRepository, {required repository});

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await userRepository.loginUser(params.email, params.password);
  }
}
