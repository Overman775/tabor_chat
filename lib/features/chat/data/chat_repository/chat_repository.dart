import 'dart:async';

import '../../chat.dart';

abstract class ChatRepository {
  Stream<Map<String, dynamic>> get chatStream;
  StreamSink<Map<String, dynamic>> get chatSink;
  Future<List<RoomMessage>> loadHistory(String roomName);
}
