import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
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
    }
  }
}
