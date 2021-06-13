import 'dart:async';

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
  late StreamSink<dynamic> _chatSink;

  @override
  Future<void> init(SocketConfiguration config) async {
    final Map<String, String> queryParameters = <String, String>{
      'username': config.userName,
    };

    final Uri socketUri = Uri.parse(config.socketUrl).replace(queryParameters: queryParameters);

    _channel = IOWebSocketChannel.connect(
      socketUri,
      pingInterval: config.pingInterval,
    );

    _chatStream = _channel.stream.asBroadcastStream();
    _chatSink = _channel.sink;
  }

  @override
  Stream<dynamic> get chatStream => _chatStream;

  @override
  StreamSink<dynamic> get chatSink => _chatSink;

  @override
  Future<void> close() async => _channel.sink.close(status.goingAway);
}
