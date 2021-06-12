import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../../core.dart';
import 'socket_config.dart';

@Singleton(as: SocketService)
class SocketServiceImplementation implements SocketService {
  SocketServiceImplementation();
  late IOWebSocketChannel _channel;
  late Stream<dynamic> _chatStream;

  @override
  void init(SocketConfiguration config) {
    final Map<String, String> queryParameters = <String, String>{
      'username': config.userName,
    };

    final Uri socketUri = Uri.parse(config.socketUrl)..replace(queryParameters: queryParameters);

    _channel = IOWebSocketChannel.connect(
      socketUri,
      pingInterval: config.pingInterval,
    );
    _chatStream = _channel.stream.asBroadcastStream();
  }

  @override
  Stream<dynamic> get chatStream => _chatStream;

  @override
  Future<void> close() async => _channel.sink.close(status.goingAway);
}
