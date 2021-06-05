import 'network.dart';

abstract class NetworkService {
  NetworkService({
    required this.configuration,
  });

  final NetworkConfiguration configuration;

  //TODO распределить на null и required параметры для запросов get, post, и т.д.

  /// Make a GET request to `url`
  Future<T?> get<T>(
    String url, {
    Map<String, dynamic> queryParameters,
  });

  /// Make a POST request to `url` with data in `body`.
  Future<T?> post<T>(
    String url, {
    Map<String, dynamic> body,
    Map<String, dynamic> queryParameters,
  });

  /// Make a PUT request to `url` with data in `body`.
  Future<T?> put<T>(
    String url, {
    Map<String, dynamic> body,
    Map<String, dynamic> queryParameters,
  });

  /// Make a PATCH request to `url` with data in `body`.
  Future<T?> patch<T>(
    String url, {
    Map<String, dynamic> body,
    Map<String, dynamic> queryParameters,
  });

  /// Make a delete request to `url`
  Future<T?> delete<T>(
    String url, {
    Map<String, dynamic> queryParameters,
  });
}
