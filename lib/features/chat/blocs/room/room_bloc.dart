import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../chat.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc({required this.repository}) : super(RoomInitial());

  final ChatRepository repository;

  @override
  Stream<RoomState> mapEventToState(
    RoomEvent event,
  ) async* {
    if (event is GetRoomEvent) {
      yield RoomLoadingState();
      final List<RoomMessage> messages = await repository.loadHistory(event.roomName);
      yield RoomLoadedState(messages: messages);
    }
  }
}
