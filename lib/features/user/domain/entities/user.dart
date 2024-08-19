import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String? id;
  final String? name;
  final String email;
  final String password;

  User({
    this.id,
    this.name,
    required this.email,
    required this.password,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    email,
    password,
  ];
}