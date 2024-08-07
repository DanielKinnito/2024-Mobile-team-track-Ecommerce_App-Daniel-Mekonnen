import 'failure.dart';

class NotFound extends Failure {
  // ignore: use_super_parameters
  const NotFound({message = 'Not Found'}) : super(message: message);
}