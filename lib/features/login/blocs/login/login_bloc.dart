import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/core.dart';
import '../../../rooms/rooms.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.navigator, required this.injector}) : super(LoginInitial());

  final RouterService navigator;
  final GetIt injector;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginAuthorizeEvent) {
      yield LoginSendingState();
      await Future<void>.delayed(const Duration(seconds: 3));
      yield LoginSentState();

      injector.registerFactory<String>(() => event.name, instanceName: 'userName');
      navigator.go(RoomsRoutes.rooms, removeUntil: (Route<dynamic> route) => false);
    }
  }
}
