import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetry {
  DioConnectivityRequestRetry({
    required this.dio,
    required this.connectivity,
  });

  final Dio dio;
  final Connectivity connectivity;

  Future<Response<dynamic>> scheduleRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription<ConnectivityResult> streamSubscription;
    final Completer<Response<dynamic>> responseCompleter = Completer<Response<dynamic>>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (ConnectivityResult connectivityResult) async {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription.cancel();
          // Complete the completer instead of returning

          // Error fix: Bad state: Can't finalize a finalized MultipartFile
          // https://github.com/flutterchina/dio/issues/482
          if (requestOptions.data is FormData) {
            final FormData formData = FormData();
            formData.fields.addAll((requestOptions.data as FormData).fields);

            for (final MapEntry<String, MultipartFile> mapFile in (requestOptions.data as FormData).files) {
              formData.files.add(MapEntry<String, MultipartFile>(
                  mapFile.key,
                  await MultipartFile.fromFile(requestOptions.headers['path'].toString(),
                      filename: mapFile.value.filename)));
            }
            requestOptions.data = formData;
          }
          responseCompleter.complete(
            dio.request<dynamic>(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
