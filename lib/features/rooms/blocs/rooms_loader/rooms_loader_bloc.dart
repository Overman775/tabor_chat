import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../rooms.dart';

part 'rooms_loader_event.dart';
part 'rooms_loader_state.dart';

class RoomsLoaderBloc extends Bloc<RoomsLoaderEvent, RoomsLoaderState> {
  RoomsLoaderBloc({required this.navigator, required this.repository}) : super(RoomsInitial());

  final RouterService navigator;
  final RoomsRepository repository;

  @override
  Stream<RoomsLoaderState> mapEventToState(
    RoomsLoaderEvent event,
  ) async* {
    if (event is GetRoomsLoaderEvent) {
      yield RoomsLoadingState();
      final List<Room> rooms = await repository.loadRooms();
      yield RoomsLoadedState(rooms: rooms);
    }
  }
}
