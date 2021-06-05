class NetworkException implements Exception {
  const NetworkException({required this.prefix, this.message});

  factory NetworkException.fromStatusCode(int statusCode, {String? message}) {
    switch (statusCode) {
      case 400:
        return BadRequestNetworkException(message: message);
      case 401:
        return UnauthorizedNetworkException(message: message);
      case 403:
        return ForbiddenNetworkException(message: message);
      case 404:
        return NotFoundNetworkException(message: message);
      case 405:
        return MethodNotAllowedNetworkException(message: message);
      case 408:
        return RequestTimeoutNetworkException(message: message);
      case 422:
        return UnprocessableEntityNetworkException(message: message);
      case 429:
        return RequestLimitNetworkException(message: message);
      case 500:
      case 501:
      case 502:
        return ServerNetworkException(message: message);
      case 503:
        return ServiceUnavailableNetworkException(message: message);
      default:
        return NetworkException(prefix: 'NetworkException', message: message);
    }
  }

  final String prefix;
  final String? message;

  @override
  String toString() {
    if (message != null) {
      return '$prefix: $message';
    } else {
      return prefix;
    }
  }
}

/// HTTP 400
class BadRequestNetworkException extends NetworkException {
  const BadRequestNetworkException({String? message})
      : super(
          prefix: 'Bad request to the server',
          message: message,
        );
}

/// HTTP 401
class UnauthorizedNetworkException extends NetworkException {
  const UnauthorizedNetworkException({String? message})
      : super(
          prefix: 'Unauthorized access to the server',
          message: message,
        );
}

/// HTTP 403
class ForbiddenNetworkException extends NetworkException {
  const ForbiddenNetworkException({String? message})
      : super(
          prefix: 'Access forbidden by server, try again',
          message: message,
        );
}

/// HTTP 404
class NotFoundNetworkException extends NetworkException {
  const NotFoundNetworkException({String? message})
      : super(
          prefix: 'Requested data was not found',
          message: message,
        );
}

/// HTTP 405
class MethodNotAllowedNetworkException extends NetworkException {
  const MethodNotAllowedNetworkException({String? message})
      : super(
          prefix: 'Method Not Allowed',
          message: message,
        );
}

/// HTTP 408
class RequestTimeoutNetworkException extends NetworkException {
  const RequestTimeoutNetworkException({String? message})
      : super(
          prefix: 'Request Timeout',
          message: message,
        );
}

/// HTTP 422
class UnprocessableEntityNetworkException extends NetworkException {
  const UnprocessableEntityNetworkException({String? message})
      : super(
          prefix: 'Unprocessable Entity',
          message: message,
        );
}

/// HTTP 429
class RequestLimitNetworkException extends NetworkException {
  const RequestLimitNetworkException({String? message})
      : super(
          prefix: 'You have exceeded your request limit',
          message: message,
        );
}

/// HTTP 500-502
class ServerNetworkException extends NetworkException {
  const ServerNetworkException({String? message})
      : super(
          prefix: 'An error occurred form the server',
          message: message,
        );
}

/// HTTP 503
class ServiceUnavailableNetworkException extends NetworkException {
  const ServiceUnavailableNetworkException({String? message})
      : super(
          prefix: 'Service Unavailable',
          message: message,
        );
}

///
class SendTimeoutNetworkException extends NetworkException {
  const SendTimeoutNetworkException({String? message})
      : super(
          prefix: 'Send Timeout',
          message: message,
        );
}

///
class ReceiveTimeoutNetworkException extends NetworkException {
  const ReceiveTimeoutNetworkException({String? message})
      : super(
          prefix: 'Send Timeout',
          message: message,
        );
}

///
class CanceledNetworkException extends NetworkException {
  const CanceledNetworkException({String? message})
      : super(
          prefix: 'Canceled request',
          message: message,
        );
}

///
class ConnectTimeoutNetworkException extends NetworkException {
  const ConnectTimeoutNetworkException({String? message})
      : super(
          prefix: 'Connect timeout',
          message: message,
        );
}
