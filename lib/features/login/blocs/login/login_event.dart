part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => <Object>[];
}

class LoginAuthorizeEvent extends LoginEvent {
  const LoginAuthorizeEvent({required this.name});

  final String name;
}
