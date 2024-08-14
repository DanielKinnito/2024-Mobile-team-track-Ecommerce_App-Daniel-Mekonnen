import 'package:equatable/equatable.dart';

/// Represents a failure that can occur in the application.
///
/// This is an abstract class that should be extended by specific failure classes.
/// Each failure class should provide a [message] that describes the failure.
/// The [props] getter returns a list of properties that are used to determine
/// if two failures are equal.
abstract class Failure extends Equatable {
  final String message;

  /// Creates a new instance of [Failure] with the given [message].
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Represents a failure caused by a server error.
///
/// This class extends [Failure] and provides a [message] that describes the server failure.
class ServerFailure extends Failure {
  /// Creates a new instance of [ServerFailure] with the given [message].
  const ServerFailure(super.message);
}

/// Represents a failure caused by a connection error.
///
/// This class extends [Failure] and provides a [message] that describes the connection failure.
class ConnectionFailure extends Failure {
  /// Creates a new instance of [ConnectionFailure] with the given [message].
  const ConnectionFailure(super.message);
}

/// Represents a failure caused by a database error.
///
/// This class extends [Failure] and provides a [message] that describes the database failure.
class DatabaseFailure extends Failure {
  /// Creates a new instance of [DatabaseFailure] with the given [message].
  const DatabaseFailure(super.message);
}

/// Represents a failure caused by a cache error.
///
/// This class extends [Failure] and provides a [message] that describes the cache failure.
class CacheFailure extends Failure {
  /// Creates a new instance of [CacheFailure] with the given [message].
  const CacheFailure(super.message);
}