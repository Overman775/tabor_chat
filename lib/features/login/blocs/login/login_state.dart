part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => <Object>[];
}

class LoginInitial extends LoginState {}

class LoginSendingState extends LoginState {}

class LoginSentState extends LoginState {}

class LoginErrorState extends LoginState {}
