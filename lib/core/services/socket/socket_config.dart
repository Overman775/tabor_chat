class SocketConfiguration {
  SocketConfiguration({
    required this.socketUrl,
    this.reconnectInterval = const Duration(seconds: 1),
    required this.userName,
  });

  final String socketUrl;
  final Duration reconnectInterval;
  final String userName;

  @override
  String toString() =>
      'SocketConfiguration(socketUrl: $socketUrl, pingInterval: $reconnectInterval, userName: $userName)';
}
