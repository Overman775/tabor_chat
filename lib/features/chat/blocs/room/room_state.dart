part of 'room_bloc.dart';

abstract class RoomState extends Equatable {
  const RoomState();

  @override
  List<Object> get props => <Object>[];
}

class RoomInitial extends RoomState {}

class RoomLoadingState extends RoomState {}

class RoomMessagesState extends RoomState {
  const RoomMessagesState({required this.messages});

  final List<RoomMessage> messages;

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => messages.hashCode;

  @override
  String toString() => 'RoomMessagesState(messages: $messages)';
}

class RoomErrorState extends RoomState {}
