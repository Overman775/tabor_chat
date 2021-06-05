class NetworkConfiguration {
  NetworkConfiguration({
    required this.baseUrl,
    this.connectTimeout,
    this.receiveTimeout,
    this.sendTimeout,
  });

  final String baseUrl;
  final int? connectTimeout;
  final int? receiveTimeout;
  final int? sendTimeout;
}
