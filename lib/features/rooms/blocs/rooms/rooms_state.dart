part of 'rooms_bloc.dart';

abstract class RoomsState extends Equatable {
  const RoomsState();

  @override
  List<Object> get props => <Object>[];
}

class RoomsInitial extends RoomsState {}

class RoomsLoadingState extends RoomsState {}

class RoomsLoadedState extends RoomsState {
  const RoomsLoadedState({required this.rooms});

  final List<Room> rooms;

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => rooms.hashCode;

  @override
  String toString() => 'RoomsLoadedState(rooms: $rooms)';
}

class RoomsErrorState extends RoomsState {}
