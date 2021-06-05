import 'dart:io';

import 'package:dio/dio.dart';
import 'dio_connectivity_request_retry.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  RetryOnConnectionChangeInterceptor({
    required this.requestRetry,
  });

  final DioConnectivityRequestRetry requestRetry;

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    if (_shouldRetry(err)) {
      requestRetry
          .scheduleRequestRetry(err.requestOptions)
          .then(
            (_) => handler.next(err),
          )
          .catchError((dynamic e) {
        final DioError _err = DioError(
          requestOptions: err.response!.requestOptions,
          error: e,
        );
        handler.next(_err);
      });
    } else {
      // Let the error pass through if it's not the error we're looking for
      handler.next(err);
    }
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.other && err.error != null && err.error is SocketException;
  }
}
