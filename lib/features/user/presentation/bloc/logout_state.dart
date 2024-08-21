part of 'logout_bloc.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();
  
  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LoggedOutState extends LogoutState {}

class LogoutError extends LogoutState {
  final String message;

  const LogoutError(this.message);

  @override
  List<Object> get props => [message];
}
