part of 'initialization_bloc.dart';

abstract class InitializationEvent extends Equatable {
  const InitializationEvent();

  @override
  List<Object> get props => <Object>[];
}

class InitializationStartEvent extends InitializationEvent {
  const InitializationStartEvent();
}
