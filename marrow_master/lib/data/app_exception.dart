class AppExceptions implements Exception {
  final String? _message;
  final String? _prefix;
  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return "$_message";
  }
}

class InternetException extends AppExceptions {
  InternetException([String? message]) : super(message, "No Internet");
}

class RequestTimoutException extends AppExceptions {
  RequestTimoutException([String? message])
      : super(message, "Request Time Out");
}

class ServerException extends AppExceptions {
  ServerException([String? message]) : super(message, "Internal Server Error");
}

class ConnectionClosedException extends AppExceptions {
  ConnectionClosedException([String? message])
      : super(message, "Connection closed while receiving data");
}

class InvalidUrlException extends AppExceptions {
  InvalidUrlException([super.message]);
}

class InvalidTokenException extends AppExceptions {
  InvalidTokenException([super.message]);
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(message, "Error while communication");
}
