part of 'initialization_bloc.dart';

abstract class InitializationState extends Equatable {
  const InitializationState();

  @override
  List<Object> get props => <Object>[];
}

class InitializationInitial extends InitializationState {}

class InitializationProgress extends InitializationState {
  const InitializationProgress(this.moduleName);

  final String moduleName;

  @override
  List<Object> get props => <Object>[moduleName];
}

class InitializationDone extends InitializationState {}

class InitializationError extends InitializationState {
  const InitializationError(this.moduleName, this.error);

  final String moduleName;
  final String error;

  @override
  List<Object> get props => <Object>[moduleName, error];
}
