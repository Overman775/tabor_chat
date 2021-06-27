import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../chat/chat.dart';
import '../../rooms.dart';

part 'rooms_event.dart';
part 'rooms_state.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  RoomsBloc({
    required this.navigator,
    required this.repository,
  }) : super(RoomsInitial());

  final RouterService navigator;
  final RoomsRepository repository;

  late List<Room> _rooms;
  StreamSubscription<dynamic>? _chatSubscription;

  void _chatListener(Map<String, dynamic> value) {
    final RoomMessage message = RoomMessage.fromJson(value);

    final int roomFromMessageIndex = _rooms.indexWhere((Room e) => e.name == message.room);

    if (roomFromMessageIndex >= 0) {
      _rooms[roomFromMessageIndex] = _rooms[roomFromMessageIndex].copyWith(lastMessage: message);
    } else {
      final Room newRoom = Room(name: message.room, lastMessage: message);
      _rooms.add(newRoom);
    }
    add(UpdateRoomsEvent());
  }

  void _chatSubscribe() {
    _chatSubscription ??= repository.chatStream.listen(_chatListener, cancelOnError: false);
  }

  @override
  Stream<RoomsState> mapEventToState(
    RoomsEvent event,
  ) async* {
    if (event is GetRoomsEvent) {
      yield RoomsLoadingState();
      _rooms = await repository.loadRooms();
      yield RoomsLoadedState(rooms: _rooms);
    } else if (event is NewRoomsEvent) {
      _rooms.insert(0, Room(name: event.roomName));
      yield RoomsLoadedState(rooms: _rooms);
    } else if (event is UpdateRoomsEvent) {
      yield RoomsLoadedState(rooms: _rooms);
    }
    _chatSubscribe();
  }

  @override
  Future<void> close() async {
    await _chatSubscription?.cancel();
    return super.close();
  }
}
