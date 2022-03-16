class NetworkException implements Exception {
  String? message;
  int? statusCode;

  NetworkException({this.message, this.statusCode});
}

class Unautherized extends NetworkException {
  Unautherized({message, statusCode})
      : super(message: message, statusCode: statusCode);
}

class PaymentRequired extends NetworkException {
  PaymentRequired({message, statusCode})
      : super(message: message, statusCode: statusCode);
}

class UnprocessableEntity extends NetworkException {
  UnprocessableEntity({message, statusCode})
      : super(message: message, statusCode: statusCode);
}

class TooManyRequests extends NetworkException {
  TooManyRequests({message, statusCode})
      : super(message: message, statusCode: statusCode);
}
