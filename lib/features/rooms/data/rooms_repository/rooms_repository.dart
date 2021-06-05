import '../../rooms.dart';

abstract class RoomsRepository {
  Future<List<Room>> loadRooms();
}
