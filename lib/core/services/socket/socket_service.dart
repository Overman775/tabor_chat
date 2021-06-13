import 'dart:async';

import 'socket_config.dart';

abstract class SocketService {
  Stream<Map<String, dynamic>> get chatStream;
  StreamSink<Map<String, dynamic>> get chatSink;

  Future<void> init(SocketConfiguration config);
  Future<void> close();
}
