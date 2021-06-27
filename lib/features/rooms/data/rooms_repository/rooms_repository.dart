import '../../rooms.dart';

abstract class RoomsRepository {
  Future<List<Room>> loadRooms();
  Stream<Map<String, dynamic>> get chatStream;
}
