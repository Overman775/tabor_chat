part of 'room_bloc.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object> get props => <Object>[];
}

class GetRoomEvent extends RoomEvent {
  const GetRoomEvent({
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

  final RoomMessageRequest message;

  @override
  List<Object> get props => <Object>[message];
}
