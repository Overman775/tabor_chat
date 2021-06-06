import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/core.dart';
import '../../../rooms/rooms.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.navigator}) : super(LoginInitial());

  final RouterService navigator;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginAuthorizeEvent) {
      yield LoginSendingState();
      await Future<void>.delayed(const Duration(seconds: 3));
      yield LoginSentState();
      navigator.go(RoomsRoutes.rooms, removeUntil: (Route<dynamic> route) => false);
    }
  }
}
