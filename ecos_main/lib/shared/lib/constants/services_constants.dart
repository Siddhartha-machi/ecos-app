class HttpMethod {
  static const String get = 'GET';
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
}

class StatusCodes {
  // Success (2xx)
  static const int ok = 200;
  static const int created = 201;
  static const int noContent = 204;

  // Client Errors (4xx)
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;

  // Server Errors (5xx)
  static const int internalServerError = 500;
}
