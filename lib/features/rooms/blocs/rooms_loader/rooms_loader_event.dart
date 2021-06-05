part of 'rooms_loader_bloc.dart';

abstract class RoomsLoaderEvent extends Equatable {
  const RoomsLoaderEvent();

  @override
  List<Object> get props => <Object>[];
}

class GetRoomsLoaderEvent extends RoomsLoaderEvent {}
