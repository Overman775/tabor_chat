import 'dart:async';

import 'socket_config.dart';

abstract class SocketService {
  Stream<dynamic> get chatStream;
  StreamSink<dynamic> get chatSink;

  Future<void> init(SocketConfiguration config);
  Future<void> close();
}
