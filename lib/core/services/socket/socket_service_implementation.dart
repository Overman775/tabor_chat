import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../core.dart';
import 'socket_config.dart';

@Singleton(as: SocketService)
class SocketServiceImplementation implements SocketService {
  SocketServiceImplementation();

  late WebSocket _channel;
  final StreamController<Map<String, dynamic>> _chatController = StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Map<String, dynamic>> _messageController = StreamController<Map<String, dynamic>>();

  bool get socketIsOpen => _channel.closeCode == null;

  @override
  Future<void> init(SocketConfiguration config) async {
    final Map<String, String> queryParameters = <String, String>{
      'username': config.userName,
    };

    final Uri socketUri = Uri.parse(config.socketUrl).replace(queryParameters: queryParameters);

    try {
      _channel = await WebSocket.connect(socketUri.toString());
      _initSocketListener(config);
      _initMessageListener();
    } catch (e) {
      logger.e('Can not connect WS', e);
    }
  }

  Future<void> reconnect(SocketConfiguration config) async {
    if (socketIsOpen) {
      await _channel.close();
    }
    await Future<void>.delayed(config.reconnectInterval);

    await init(config);
  }

  void _initSocketListener(SocketConfiguration config) {
    _channel.listen((dynamic data) {
      final Map<String, dynamic> message = json.decode(data as String) as Map<String, dynamic>;

      logger.d(message);
      _chatController.add(message);
    }, onDone: () {
      logger.d('Socket aborted');
      reconnect(config);
    }, onError: (dynamic e) async {
      logger.e('Socket Error', e);
      reconnect(config);
    });
  }

  void _initMessageListener() {
    _messageController.stream.listen((Map<String, dynamic> data) {
      if (socketIsOpen) {
        logger.d(data);
        _channel.add(json.encode(data));
      }
    });
  }

  @override
  Stream<Map<String, dynamic>> get chatStream => _chatController.stream;

  @override
  StreamSink<Map<String, dynamic>> get chatSink => _messageController.sink;

  @override
  Future<void> close() async {
    await _channel.close();
    await _chatController.close();
    await _messageController.close();
  }
}
