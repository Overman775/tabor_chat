import '../../chat.dart';

abstract class ChatRepository {
  Future<List<RoomMessage>> loadHistory(String roomName);
}
