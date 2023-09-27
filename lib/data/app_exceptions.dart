class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions(this._message, this._prefix);
}

class InternetException extends AppExceptions {
  InternetException(String? message) : super(message, "NO Internet");
}

class RequestTimeout extends AppExceptions {
  RequestTimeout(String? message) : super(message, "Request Timeout");
}

class SocketException extends AppExceptions {
  SocketException(String? message) : super(message, "Internal server error");
}

class InvalidUrlException extends AppExceptions {
  InvalidUrlException(String? message) : super(message, "Invalid Url");
}

class FetchDataException extends AppExceptions {
  FetchDataException(String? message) : super(message, '');
}
