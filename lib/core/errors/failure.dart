import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message: message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message: message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.message});
}