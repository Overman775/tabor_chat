part of 'rooms_loader_bloc.dart';

abstract class RoomsLoaderState extends Equatable {
  const RoomsLoaderState();

  @override
  List<Object> get props => <Object>[];
}

class RoomsInitial extends RoomsLoaderState {}

class RoomsLoadingState extends RoomsLoaderState {}

class RoomsLoadedState extends RoomsLoaderState {
  const RoomsLoadedState({required this.rooms});

  final List<Room> rooms;

  @override
  List<Object> get props => <Object>[rooms];
}

class RoomsErrorState extends RoomsLoaderState {}
