import 'package:dio/dio.dart';

import '../network_exceptions.dart';

class ExceptionsStatusCodeInterceptor extends Interceptor {
  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    if (err.type == DioErrorType.response) {
      if (err.response?.statusCode != null) {
        throw NetworkException.fromStatusCode(err.response!.statusCode!, message: err.message);
      } else {
        handler.next(err);
      }
    }
    if (err.type == DioErrorType.cancel) {
      throw CanceledNetworkException(message: err.message);
    }
    if (err.type == DioErrorType.connectTimeout) {
      throw ConnectTimeoutNetworkException(message: err.message);
    }
    if (err.type == DioErrorType.receiveTimeout) {
      throw ReceiveTimeoutNetworkException(message: err.message);
    }
    if (err.type == DioErrorType.sendTimeout) {
      throw SendTimeoutNetworkException(message: err.message);
    } else {
      handler.next(err);
    }
  }
}
