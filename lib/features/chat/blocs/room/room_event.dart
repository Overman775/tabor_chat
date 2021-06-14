part of 'room_bloc.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object> get props => <Object>[];
}

class GetRoomHistoryEvent extends RoomEvent {
  const GetRoomHistoryEvent({
    required this.roomName,
  });

  final String roomName;
}

class GetRoomNewEvent extends RoomEvent {
  const GetRoomNewEvent({
    required this.roomName,
  });

  final String roomName;
}

class _MessageFromRoomEvent extends RoomEvent {
  const _MessageFromRoomEvent(this.message);

  final RoomMessage message;

  @override
  List<Object> get props => <Object>[message];
}

class SendMessageRoomEvent extends RoomEvent {
  const SendMessageRoomEvent(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}
