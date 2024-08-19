class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

class RegisterParams {
  final String email;
  final String password;
  final String name;

  RegisterParams({required this.email, required this.password, required this.name});
}