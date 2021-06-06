part of 'room_bloc.dart';

abstract class RoomState extends Equatable {
  const RoomState();

  @override
  List<Object> get props => <Object>[];
}

class RoomInitial extends RoomState {}

class RoomLoadingState extends RoomState {}

class RoomLoadedState extends RoomState {
  const RoomLoadedState({required this.messages});

  final List<RoomMessage> messages;

  @override
  List<Object> get props => <Object>[messages];
}

class RoomErrorState extends RoomState {}
