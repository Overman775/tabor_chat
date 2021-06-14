part of 'rooms_bloc.dart';

abstract class RoomsEvent extends Equatable {
  const RoomsEvent();

  @override
  List<Object> get props => <Object>[];
}

class GetRoomsEvent extends RoomsEvent {}

class NewRoomsEvent extends RoomsEvent {
  const NewRoomsEvent(this.roomName);

  final String roomName;

  @override
  List<Object> get props => <Object>[roomName];
}
