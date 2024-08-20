import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/params/params.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/user_repository.dart';

class RegisterUser
    extends Usecase<Future<Either<Failure, String>>, RegisterParams> {
  final UserRepository userRepository;

  RegisterUser(this.userRepository);

  @override
  Future<Either<Failure, String>> call(RegisterParams params) async {
    return await userRepository.registerUser(
        params.email, params.password, params.name);
  }
}
