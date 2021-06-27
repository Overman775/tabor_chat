import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/core.dart';
import '../../../login/login.dart';
import '../../initialization.dart';

part 'initialization_event.dart';
part 'initialization_state.dart';

class InitializationBloc extends Bloc<InitializationEvent, InitializationState> {
  InitializationBloc({
    required this.navigator,
    required this.repository,
  }) : super(InitializationInitial());

  final RouterService navigator;
  final InitializationPreloaderRepository repository;

  @override
  Stream<InitializationState> mapEventToState(
    InitializationEvent event,
  ) async* {
    if (event is InitializationStartEvent) {
      await _loadingSettings();
      navigator.go(LoginRoutes.login, removeUntil: (Route<dynamic> route) => false);
    }
  }

  Future<void> _loadingSettings() async {
    final InitializedSettings result = await repository.loadSettings();

    injector.registerSingleton<InitializedSettings>(result);
  }
}
