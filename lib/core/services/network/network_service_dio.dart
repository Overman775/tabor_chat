import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'dio_interceptors/dio_connectivity_request_retry.dart';
import 'dio_interceptors/dio_error_interceptor.dart';
import 'dio_interceptors/dio_logger_interceptor.dart';
import 'dio_interceptors/dio_retry_interceptor.dart';
import 'network.dart';

/// Basic HTTP request service wrapper around the common
/// HTTP Methods: GET, POST, PUT, PATCH, DELETE
@Singleton(as: NetworkService)
class NetworkServiceDio implements NetworkService {
  NetworkServiceDio({
    required this.configuration,
    required this.connectivity,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: configuration.baseUrl,
        connectTimeout: configuration.connectTimeout,
        receiveTimeout: configuration.receiveTimeout,
        sendTimeout: configuration.sendTimeout,
        setRequestContentTypeWhenNoPayload: true,
      ),
    );

    ///Register interceptors
    final DioConnectivityRequestRetry requestRetry = DioConnectivityRequestRetry(dio: _dio, connectivity: connectivity);
    final RetryOnConnectionChangeInterceptor retryInterceptor =
        RetryOnConnectionChangeInterceptor(requestRetry: requestRetry);

    _dio.interceptors..add(retryInterceptor)..add(ExceptionsStatusCodeInterceptor())..add(LoggerInterceptor());
  }

  @factoryMethod
  static NetworkServiceDio injectorFactory(
    Connectivity connectivity,
    @Named('baseUrl') String baseUrl,
  ) {
    return NetworkServiceDio(
      connectivity: connectivity,
      configuration:
          NetworkConfiguration(baseUrl: baseUrl, connectTimeout: 60000, receiveTimeout: 60000, sendTimeout: 60000),
    );
  }

  @override
  final NetworkConfiguration configuration;
  final Connectivity connectivity;

  late Dio _dio;

  @override
  Future<T?> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Response<T?> response;
    response = await _dio.get<T?>(
      url,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future<T?> post<T>(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response<T?> response;

    FormData? data;

    if (body != null) {
      data = FormData.fromMap(body);
    }

    response = await _dio.post<T?>(
      url,
      queryParameters: queryParameters,
      data: data,
    );

    return response.data;
  }

  @override
  Future<T?> delete<T>(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response<T?> response;
    FormData? data;

    if (body != null) {
      data = FormData.fromMap(body);
    }
    response = await _dio.delete<T?>(
      url,
      queryParameters: queryParameters,
      data: data,
    );
    return response.data;
  }

  @override
  Future<T?> patch<T>(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response<T?> response;

    FormData? data;

    if (body != null) {
      data = FormData.fromMap(body);
    }

    response = await _dio.patch<T?>(
      url,
      queryParameters: queryParameters,
      data: data,
    );

    return response.data;
  }

  @override
  Future<T?> put<T>(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response<T?> response;
    FormData? data;

    if (body != null) {
      data = FormData.fromMap(body);
    }
    response = await _dio.put<T?>(
      url,
      queryParameters: queryParameters,
      data: data,
    );

    return response.data;
  }
}
