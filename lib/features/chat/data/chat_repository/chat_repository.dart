import 'dart:async';

import '../../chat.dart';

abstract class ChatRepository {
  Stream<dynamic> get chatStream;
  StreamSink<dynamic> get chatSink;
  Future<List<RoomMessage>> loadHistory(String roomName);
}
