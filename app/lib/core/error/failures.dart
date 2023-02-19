
import 'failure_codes.dart';

abstract class Failure {
  final String code;
  final String message;

  const Failure({required this.code, required this.message});
}

class CacheFailure extends Failure {
  const CacheFailure({String message = 'Cache failure'})
      : super(code: CACHE_FAILURE, message: message);
}

class ServerFailure extends Failure {
  const ServerFailure({String message = 'Server failure'})
      : super(code: SERVER_FAILURE, message: message);
}

class ClientFailure extends Failure {
  const ClientFailure({String message = 'Client failure'})
      : super(code: CLIENT_FAILURE, message: message);
}

class NetworkFailure extends Failure {
  const NetworkFailure({String message = 'Network failure'})
      : super(code: NETWORK_FAILURE, message: message);
}
