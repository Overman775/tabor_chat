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
