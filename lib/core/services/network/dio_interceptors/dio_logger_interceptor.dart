import 'package:dio/dio.dart';
import '../../../core.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    logger.d(<String, dynamic>{
      'TYPE': 'Request >>>',
      'URL': '${options.baseUrl}${options.path}',
      'HEADER': options.headers,
      'BODY': _formatData(options.data),
    });

    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    logger.d(<String, dynamic>{
      'TYPE': 'Response <<<',
      'HEADER': response.headers.map,
      'BODY': _formatData(response.data),
    });
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logger.e(err.message, err.error, err.stackTrace);
    handler.next(err);
  }

  dynamic _formatData(dynamic data) {
    if (data == null) {
      return null;
    }
    if (data is FormData) {
      return data.fields.toString();
    }

    return data;
  }
}
