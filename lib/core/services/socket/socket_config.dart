class SocketConfiguration {
  SocketConfiguration({
    required this.socketUrl,
    this.pingInterval = const Duration(seconds: 1),
    required this.userName,
  });

  final String socketUrl;
  final Duration pingInterval;
  final String userName;

  @override
  String toString() => 'SocketConfiguration(socketUrl: $socketUrl, pingInterval: $pingInterval, userName: $userName)';
}
