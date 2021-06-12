import 'socket_config.dart';

abstract class SocketService {
  Stream<dynamic> get chatStream;

  void init(SocketConfiguration config);
  Future<void> close();
}
